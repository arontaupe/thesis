import os
import cv2
import numpy as np
import time
import cairosvg
from logger_config import logger

TEMPLATE_DIR = "./markers/"
USE_ORB = False  # Set to True to use ORB, False to use SIFT


# Load and convert SVG templates to grayscale images
def load_template(filename):
    """Load a template image, converting SVG to grayscale if necessary."""
    template_path = os.path.join(TEMPLATE_DIR, filename)

    if filename.endswith(".svg"):
        # Convert SVG to PNG (grayscale)
        png_data = cairosvg.svg2png(url=template_path)
        np_arr = np.frombuffer(png_data, dtype=np.uint8)
        template = cv2.imdecode(np_arr, cv2.IMREAD_GRAYSCALE)
    else:
        # Load JPG/PNG directly
        template = cv2.imread(template_path, cv2.IMREAD_GRAYSCALE)

    return template


# Load all templates
templates = {}
logger.info("🔄 Loading templates...")
start_time = time.time()

for filename in os.listdir(TEMPLATE_DIR):
    if filename.endswith((".jpg", ".png", ".svg")):
        template_name = os.path.splitext(filename)[0]
        template = load_template(filename)

        if template is not None:
            templates[template_name] = template
        else:
            logger.error(f"❌ Failed to load template: {filename}")

logger.info(f"✅ Template loading complete in {time.time() - start_time:.2f} seconds.\n")

# Log the loaded templates once all are loaded
logger.info("Templates loaded: %s", ', '.join(templates.keys()))

# Initialize feature detector (SIFT or ORB)
if USE_ORB:
    detector = cv2.ORB_create(nfeatures=500)
    matcher = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
    ratio_test = 0.6  # ORB ratio test
else:
    detector = cv2.SIFT_create()
    matcher = cv2.FlannBasedMatcher(dict(algorithm=1, trees=10), dict())
    ratio_test = 0.6  # SIFT stricter ratio test


def is_valid_aspect_ratio(bounding_box, expected_aspect_ratio=1.0, tolerance=0.2):
    """Ensure detected bounding box is approximately square."""
    x, y, w, h = bounding_box
    aspect_ratio = w / float(h)
    return (expected_aspect_ratio - tolerance) <= aspect_ratio <= (expected_aspect_ratio + tolerance)


def detect_markers(image_path, templates, min_matches=15, min_area=500):
    """Detects markers using feature matching and filters based on shape constraints."""
    logger.info(f"🔄 Reading image: {image_path}")
    image = cv2.imread(image_path)

    if image is None:
        logger.error("❌ Failed to load image")
        return []

    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    detected_markers = []

    # Detect keypoints and descriptors in the input image
    kp_image, des_image = detector.detectAndCompute(gray_image, None)
    logger.info(f"🔍 Detected {len(kp_image)} keypoints in the input image.")

    keypoints_image = cv2.drawKeypoints(image, kp_image, None, (0, 255, 0), cv2.DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS)

    logger.info("🔄 Starting template matching...")

    for name, template in templates.items():
        logger.debug(f"🔍 Processing template: {name}")

        # Detect keypoints and descriptors in the template
        kp_template, des_template = detector.detectAndCompute(template, None)

        if des_template is None or des_image is None:
            continue

        logger.debug(f"🔍 Found {len(kp_template)} keypoints in template {name}.")

        # Match descriptors
        if USE_ORB:
            matches = matcher.match(des_template, des_image)
            good_matches = sorted(matches, key=lambda x: x.distance)[:min_matches]
        else:
            raw_matches = matcher.knnMatch(des_template, des_image, k=2)
            good_matches = [m for m, n in raw_matches if m.distance < ratio_test * n.distance]

        if len(good_matches) >= min_matches:
            src_pts = np.float32([kp_template[m.queryIdx].pt for m in good_matches]).reshape(-1, 1, 2)
            dst_pts = np.float32([kp_image[m.trainIdx].pt for m in good_matches]).reshape(-1, 1, 2)

            if USE_ORB:
                x_min, y_min = np.min(dst_pts, axis=0)[0]
                x_max, y_max = np.max(dst_pts, axis=0)[0]

                bounding_box = (int(x_min), int(y_min), int(x_max - x_min), int(y_max - y_min))
                if is_valid_aspect_ratio(bounding_box) and bounding_box[2] * bounding_box[3] >= min_area:
                    cv2.rectangle(image, (bounding_box[0], bounding_box[1]),
                                  (bounding_box[0] + bounding_box[2], bounding_box[1] + bounding_box[3]),
                                  (0, 255, 0), 2)
                    cv2.putText(image, name, (bounding_box[0], bounding_box[1] - 10),
                                cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0), 2)
                    detected_markers.append(name)
                else:
                    logger.warning(f"❌ {name} detected but doesn't meet square size constraints.")

            else:
                M, mask = cv2.findHomography(src_pts, dst_pts, cv2.RANSAC, 5.0)
                if M is not None:
                    h, w = template.shape
                    pts = np.float32([[0, 0], [0, h - 1], [w - 1, h - 1], [w - 1, 0]]).reshape(-1, 1, 2)
                    dst = cv2.perspectiveTransform(pts, M)

                    bounding_box = cv2.boundingRect(dst)
                    if is_valid_aspect_ratio(bounding_box) and bounding_box[2] * bounding_box[3] >= min_area:
                        hull = cv2.convexHull(dst)
                        if len(hull) == 4:
                            detected_markers.append(name)
                            image = cv2.polylines(image, [np.int32(hull)], True, (0, 255, 0), 3)
                            x, y = dst[0][0]
                            cv2.putText(image, name, (int(x), int(y) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 255, 0),
                                        2)
                        else:
                            logger.warning(f"❌ {name} detected but not forming a perfect quadrilateral.")

    debug_image_path = "./scans/detected_markers.png"
    keypoints_image_path = "./scans/keypoints.png"

    cv2.imwrite(debug_image_path, image)

    cv2.imwrite(keypoints_image_path, keypoints_image)

    logger.info(f"📸 Debug image saved to {debug_image_path}")
    logger.info(f"📸 Keypoints image saved to {keypoints_image_path}")

    return detected_markers, debug_image_path, keypoints_image_path


if __name__ == '__main__':
    image_path = "scans/snap_2025-02-23_17-10-06-836370.png"
    logger.info(f"🔍 Detecting markers in image: {image_path}")
    markers, debug_img, kp_img = detect_markers(image_path, templates)

    logger.info(f"🔍 Detected markers: {markers}")
    if markers:
        logger.info(f"📍 Total markers detected: {len(markers)}")
    else:
        logger.warning("🛑 No markers detected.")
