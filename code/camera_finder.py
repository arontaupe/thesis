import cv2
import subprocess
import re
from logger_config import logger


def get_camera_names():
    """Gets a list of available camera names using ffmpeg (macOS only)."""
    try:
        result = subprocess.run(
            ["ffmpeg", "-f", "avfoundation", "-list_devices", "true", "-i", ""],
            stderr=subprocess.PIPE,
            stdout=subprocess.PIPE,
            text=True
        )
        output = result.stderr  # ffmpeg prints device list to stderr

        # Extract camera names from ffmpeg output
        camera_lines = re.findall(r'\[AVFoundation input device @ .*?] \".*\"', output)
        cameras = [re.search(r'"(.*?)"', line).group(1) for line in camera_lines]
        return cameras
    except Exception as e:
        logger.error(f"❌ Error getting camera names: {e}")
        return []


def list_available_cameras():
    """Lists available camera indexes and their names, with a preview."""
    logger.info("🔍 Scanning for available cameras...")

    camera_names = get_camera_names()
    found_cameras = []

    for i in range(10):  # Check the first 10 indexes
        cap = cv2.VideoCapture(i, cv2.CAP_AVFOUNDATION)
        if cap.isOpened():
            name = camera_names[i] if i < len(camera_names) else f"Unknown Camera {i}"
            logger.info(f"✅ Camera {i}: {name}")
            found_cameras.append((i, name))

            ret, frame = cap.read()
            if ret:
                cv2.imshow(f"Camera {i}: {name}", frame)
                cv2.waitKey(1000)  # Show preview for 1 second
                cv2.destroyAllWindows()
            cap.release()
        else:
            logger.warning(f"❌ No camera found at index {i}")

    if found_cameras:
        logger.info("\n🎥 Available Cameras:")
        for index, name in found_cameras:
            logger.info(f"  {index}: {name}")


if __name__ == '__main__':
    list_available_cameras()
