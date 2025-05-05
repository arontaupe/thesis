# This script captures an image from the webcam, extracts' text using Tesseract or EasyOCR,
# generates a description using Ollama Vision, and uploads the text and image to Logseq.
# It also detects markers in the image using SIFT feature matching.
# The extracted text is checked for readability using textstat, and only a meaningful text is uploaded to Logseq.
# The original image is uploaded to Logseq as an asset.
# The annotated image is saved in the assets folder of the Logseq directory.

import locale
import urllib
import pytesseract
import easyocr
import ollama
import textstat
from logseq_api import Logseq, add_to_last_block_as_child
from ollama_ocr import OCRProcessor
from marker_detect import *
from camera_handler import scan
from image_analysis_pyobjc import recognize_text_pyobjc
import argparse
from datetime import datetime
from logger_config import logger
from pinry_handler import upload_and_create_pin
import time
import sys
from dotenv import load_dotenv
from success_message import show_image_with_message

import cv2
from PIL import Image

# Initialize OCR processors
MODEL_NAME = 'llama3.2-vision:11b'
ocr_processor = OCRProcessor(model_name=MODEL_NAME)

# Set locale to German
locale.setlocale(locale.LC_TIME, 'de_DE.UTF-8')


def get_image_description_ollama(image_path):
    """Uses an Ollama Vision model to generate a description of the image."""
    try:
        res = ollama.chat(
            model=MODEL_NAME,
            messages=[{'role': 'user', 'content': 'Describe this image.', 'images': [image_path]}]
        )
        return res['message']['content']
    except Exception as e:
        logger.error(f"❌ Ollama vision failed: {e}")
        return ""


def recognize_text_easyocr(image_path):
    """Uses EasyOCR to extract text from the image."""
    try:
        reader = easyocr.Reader(['en', 'de'], gpu=True)
        results = reader.readtext(image_path, detail=0, paragraph=True)
        return ' '.join(results)
    except Exception as e:
        logger.error(f"❌ EasyOCR failed: {e}")
        return ""


def recognize_text_tesseract(image_path):
    """Uses Tesseract OCR for text recognition."""
    try:
        img = Image.open(image_path)
        gray = cv2.cvtColor(np.array(img), cv2.COLOR_RGB2GRAY)
        return pytesseract.image_to_string(gray, config='--oem 1 --psm 6')
    except Exception as e:
        logger.error(f"❌ Tesseract OCR failed: {e}")
        return ""


def is_meaningful_text(text):
    """Checks if extracted text is meaningful using readability metrics."""
    if not text or len(text.split()) < 3:
        return False
    return textstat.flesch_reading_ease(text) > 40 or textstat.text_standard(text, float_output=True) > 30


def transfer_img_to_logseq(frame):
    """Saves an image and generates a timestamped path."""
    try:
        now = datetime.now()
        timestamp = now.strftime('%Y-%m-%dT%H-%M-%S-%f')[:-2]
        asset_path = f'/Users/aron/thesis/logseq/assets/scans/{timestamp}.jpg'
        cv2.imwrite(asset_path, frame)
        return asset_path
    except Exception as e:
        logger.error(f"❌ Image saving failed: {e}")
        return None


def ollama_ocr(image_path):
    """Performs OCR using Ollama's Llama Vision model."""
    try:
        return ocr_processor.process_image(image_path=image_path,
                                           format_type="markdown",
                                           preprocess=True,
                                           )
    except Exception as e:
        logger.error(f"❌ Ollama OCR failed: {e}")
        return ""


def append_block_to_logseq_page(title, block_title, block_content, logseq):
    """Appends a block to a Logseq page."""
    try:
        logseq.Editor.appendBlockInPage(title, block_title)
        add_to_last_block_as_child(title, block_content, logseq)
    except Exception as e:
        logger.error(f"❌ Logseq block append failed: {e}")


def upload_to_logseq(logseq,
                     title,
                     ocr_text,
                     caption,
                     image_path_list,
                     hashtags=[],
                     marker_list=None,
                     ollama_ocr_text=None):
    """Uploads extracted text and images to Logseq."""
    try:
        logseq.App.showMsg('Uploading to Logseq...')
        logger.info(f" {image_path_list=}")
        # insert markers as tags
        marker_string = ""

        # add the elems of hashtags to the marker_string
        for hash in hashtags:
            # strip the initial # from the hashtag
            hash = hash[1:]
            marker_list.append(hash)

        if marker_list:
            # append markers as tags to marker_string
            marker_string = ', '.join(marker_list)

            logseq.Editor.createPage(title, {'tags': f'{marker_string}, upload',
                                             'public': 'true',
                                             'author': 'Automated Archive',
                                             'source': 'Camera',
                                             'date': f'{datetime.now().strftime("%Y-%m-%d")}',
                                             'timestamp': f'{datetime.now().strftime("%H:%M:%S")}',
                                             })
            # Commented out because the markers are now tags
            # logseq.Editor.appendBlockInPage(title, "## Detected Markers:")
            # add_to_last_block_as_child(title, marker_string, logseq)
        else:
            logseq.Editor.createPage(title, {'tags': 'upload',
                                             'public': 'true',
                                             'author': 'Automated Archive',
                                             'source': 'Camera',
                                             'date': f'{datetime.now().strftime("%Y-%m-%d")}',
                                             'timestamp': f'{datetime.now().strftime("%H:%M:%S")}',
                                             })

            # logseq.Editor.appendBlockInPage(title, "## Detected Markers:")
            # add_to_last_block_as_child(title, "No markers detected.", logseq)

        # add classical ocr text
        if ocr_text:
            logseq.Editor.appendBlockInPage(title, "## OCR Text:")
            add_to_last_block_as_child(title, ocr_text, logseq)
        # add ollama ocr text
        if ollama_ocr_text:
            logseq.Editor.appendBlockInPage(title, "## Ollama OCR Text:")
            add_to_last_block_as_child(title, ollama_ocr_text, logseq)
        # upload images
        if image_path_list:
            logseq.Editor.appendBlockInPage(title, "## Scans:")
            # convert to relative paths
            relative_path_list = []
            for path in image_path_list:
                parts = path.split("assets/scans/", 1)  # Split at "scans/"
                if len(parts) > 1:
                    relative_path_list.append("./assets/scans/" + parts[1])  # Add "./" at the start

            for i, rel_image_path in enumerate(relative_path_list):
                block_property = 'annotated:: false' if i == 0 else 'annotated:: true'
                logseq.Editor.appendBlockInPage(title, f"### Scan {i + 1}\n{block_property}")
                add_to_last_block_as_child(title, f"![{rel_image_path}]({rel_image_path})", logseq)

        # add extracted text from ollama
        if caption:
            logseq.Editor.appendBlockInPage(title, "Ollama Image Caption:")
            add_to_last_block_as_child(title, caption, logseq)

        logseq.App.showMsg('Upload complete!')
    except Exception as e:
        logger.error(f"❌ Logseq upload failed: {e}")


def str_to_bool(value):
    """Convert string values from .env to boolean."""
    return value.lower() in ("true", "1", "yes")


def parse_arguments():
    """Parse and return command-line arguments."""
    load_dotenv()  # Load environment variables

    # Load environment variables with fallbacks
    default_camera = int(os.getenv("CAMERA_INDEX", 0))
    default_upload = str_to_bool(os.getenv("UPLOAD", "True"))
    default_ocr_processor = os.getenv("OCR_PROCESSOR", "pyobjc")
    default_use_ollama_caption = str_to_bool(os.getenv("USE_OLLAMA_CAPTION", "False"))
    default_use_ollama_ocr = str_to_bool(os.getenv("USE_OLLAMA_OCR", "False"))
    default_check_markers = str_to_bool(os.getenv("CHECK_MARKERS", "True"))
    default_upload_marked_image = str_to_bool(os.getenv("UPLOAD_MARKED_IMAGE", "False"))

    parser = argparse.ArgumentParser(
        description="Scan an image using a specific camera index or provide an image file.")

    parser.add_argument("--camera", type=int, default=default_camera,
                        help=f"Set the camera index (integer value required) (default: {default_camera})")

    parser.add_argument("--image", type=str, help="Optional image file path to use instead of capturing a new image")

    parser.add_argument("--upload", action="store_true", default=default_upload,
                        help=f"Enable Logseq upload (default: {default_upload})")

    parser.add_argument("--ocr-processor", choices=["easyocr", "tesseract", "pyobjc"],
                        default=default_ocr_processor,
                        help=f"Choose OCR processor (default: '{default_ocr_processor}')")

    parser.add_argument("--use-ollama-caption", action="store_true", default=default_use_ollama_caption,
                        help=f"Use Ollama for image description (default: {default_use_ollama_caption})")

    parser.add_argument("--use-ollama-ocr", action="store_true", default=default_use_ollama_ocr,
                        help=f"Use Ollama for OCR (default: {default_use_ollama_ocr})")

    parser.add_argument("--check-markers", action="store_true", default=default_check_markers,
                        help=f"Check for markers in the image (default: {default_check_markers})")

    parser.add_argument("--upload-marked-image", action="store_true", default=default_upload_marked_image,
                        help=f"Upload marked image if markers detected (default: {default_upload_marked_image})")

    return parser.parse_args()


def log_configuration(args):
    """Log configuration settings."""
    logger.info("🔧 Configuration:")
    for key, value in vars(args).items():
        logger.info(f"  {key.capitalize()}: {value}")
    logger.info("------------------------------------------------------\n")


def capture_image(camera_index):
    """Capture an image from the camera."""
    snap_timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S-%f")[:-3]
    image_path = f"./scans/snap_{snap_timestamp}.png"
    frame, captured_image_path = scan(image_path=image_path, camera_index=camera_index, hold_preview=False,
                                      preview_scale=0.5, timeout=30)
    if frame is None or captured_image_path is None:
        logger.error("❌ Image capture failed or timed out. Exiting...")
        sys.exit(1)
    return frame, captured_image_path


def extract_text(image_path, ocr_processor):
    """Extract text using the selected OCR processor."""
    ocr_text = ""
    hashtags = []
    if ocr_processor == "easyocr":
        ocr_text = recognize_text_easyocr(image_path)
    elif ocr_processor == "tesseract":
        ocr_text = recognize_text_tesseract(image_path)
    elif ocr_processor == "pyobjc":
        ocr_text, hashtags, barcode_info = recognize_text_pyobjc(image_path)
        if barcode_info:
            logger.info(f"🔍 Barcode/QR Code info: {barcode_info}")
            ocr_text += f"\n\nBarcode/QR Code Info: {barcode_info}"
    return ocr_text, hashtags


def generate_image_description(image_path, use_ollama_caption, use_ollama_ocr):
    """Generate image description and OCR text using Ollama if enabled."""
    caption = get_image_description_ollama(image_path) if use_ollama_caption else ""
    ollama_ocr_text = ollama_ocr(image_path) if use_ollama_ocr else ""
    return caption, ollama_ocr_text


def detect_and_upload_markers(image_path, check_markers, upload_marked_image):
    """Detect markers in the image and upload marked image if enabled."""
    marker_list = []

    if check_markers:
        markers, marked_image_path, keypoints_image_path = detect_markers(image_path, templates, min_area=500)
        logger.info(f" {markers=}")
        if markers:
            logger.info(f"🎯 Detected markers: {markers}, #{len(markers)}")
            marker_list.extend(markers)
            if upload_marked_image:
                marked_frame = cv2.imread(marked_image_path)
                marked_asset_path, _ = transfer_img_to_logseq(marked_frame)
        else:
            logger.info("🛑 No markers detected.")

    return marker_list, marked_image_path, keypoints_image_path


def upload_to_logseq_if_needed(upload,
                               ocr_text,
                               caption,
                               ollama_ocr_text,
                               frame,
                               marker_list,
                               marked_image_path,
                               hashtags=[]):
    """Upload to Logseq if required."""
    if upload:
        logger.info('🚀 Uploading to Logseq...')
        logseq = Logseq(host="127.0.0.1", port=12315, token="vetinari")

        asset_path_list = [transfer_img_to_logseq(frame)]
        if marker_list:
            marked_frame = cv2.imread(marked_image_path)
            marked_asset_path = transfer_img_to_logseq(marked_frame)
            asset_path_list.append(marked_asset_path)

        pagetitle = f"Upload-{datetime.now().strftime('%Y-%m-%d_%H:%M:%S')}"
        upload_to_logseq(logseq,
                         title=pagetitle,
                         ocr_text=ocr_text,
                         caption=caption,
                         image_path_list=asset_path_list,
                         marker_list=marker_list,
                         ollama_ocr_text=ollama_ocr_text,
                         hashtags=hashtags)
        logger.info(f"✅ Upload complete.")
        return pagetitle
    return None


def main():
    """Main function to execute OCR workflow."""
    try:
        args = parse_arguments()
        log_configuration(args)

        start_time = time.time()
        if args.image:

            image_path = args.image
            logger.info(f'📂 Using provided image file.: {image_path}')
            if not os.path.exists(image_path):
                logger.error(f"Error: Provided image file '{image_path}' does not exist.")
                return
            frame = cv2.imread(image_path)

            if frame is None:
                print(f"Error: Failed to load image from '{image_path}'")
                return
        else:
            frame, image_path = capture_image(args.camera)

        logger.info('🔍 Extracting text...')
        ocr_text, hashtags = extract_text(image_path, args.ocr_processor)

        # Check for meaningless text if OCR processor is easyocr or tesseract
        if args.ocr_processor in ["easyocr", "tesseract"] and not is_meaningful_text(ocr_text):
            logger.warning('❌ OCR output was not meaningful. Discarding...')
            ocr_text = ""

        logger.info(f"✅ Text extraction complete in {time.time() - start_time:.2f} seconds.\n")

        logger.info('🖼️ Get image description...')
        caption, ollama_ocr_text = generate_image_description(image_path, args.use_ollama_caption, args.use_ollama_ocr)

        logger.info(f"✅ Image description generation complete in {time.time() - start_time:.2f} seconds.\n")

        logger.info('🎯 Detecting markers...')
        marker_list, marked_image_path, keypoints_image_path = detect_and_upload_markers(image_path,
                                                                                         args.check_markers,
                                                                                         args.upload_marked_image)

        pagetitle = upload_to_logseq_if_needed(args.upload,
                                               ocr_text,
                                               caption,
                                               ollama_ocr_text,
                                               frame,
                                               marker_list,
                                               marked_image_path=marked_image_path,
                                               hashtags=hashtags)
        logseqpageurl = None
        if pagetitle:
            logger.info(f"✅ Upload complete. Page title: {pagetitle}")
            # get the page URL from the title
            baseurl = 'https://archive.petau.net/#/page/'
            # make sure the pagetitle is URL-safe, a full URL looks like this
            pagetitle_url = urllib.parse.quote(pagetitle, safe="/?#[]@&=")
            logseqpageurl = f"{baseurl}{pagetitle_url}"

        logger.info(f"Page URL: {logseqpageurl}")

        pinry_tags = marker_list + hashtags
        img_desc = caption if caption else None
        # Call the wrapper function to upload and create the pin
        pin_url = upload_and_create_pin(image_path, board_id=2, tags=pinry_tags, source_url=logseqpageurl,
                                        description=img_desc)

        if pin_url:
            logger.info(f"✅ Pin URL: {pin_url}")
            if pagetitle:
                if args.upload:
                    logger.info('Adding Pin URL to Logseq...')
                    logseq = Logseq(host="127.0.0.1", port=12315, token="vetinari")

                    append_block_to_logseq_page(pagetitle, "## Pin URL:", f'[The Pinry URL for this upload]({pin_url})',
                                                logseq)
        else:
            logger.error("❌ Pin creation failed.")

        logger.info(f"🚀 Pipeline completed in {time.time() - start_time:.2f} seconds.")
        logger.info("------------------------------------------------------\n")

        success_message = "Scan Completed Successfully!"
        url_to_open = "https://pinry.petau.net"  # URL to open after timeout

        # Show the image with the success message and open the URL after 5 seconds
        show_image_with_message(keypoints_image_path, success_message, timeout=5, url=url_to_open)

    except KeyboardInterrupt:
        logger.info("\nGracefully shutting down... Interrupt received (Ctrl+C).")
        sys.exit(0)  # Exit gracefully with status code 0


if __name__ == "__main__":
    main()
