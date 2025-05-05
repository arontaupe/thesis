import Vision
import AppKit
import os
from logger_config import logger
import re  # Regular expression module to find hashtags


def nsimage_to_cgimage(image):
    """Converts NSImage to CGImage."""
    bitmap_rep = AppKit.NSBitmapImageRep.imageRepWithData_(image.TIFFRepresentation())
    if not bitmap_rep:
        logger.error("❌ Failed to get bitmap representation.")
        return None

    cg_image = bitmap_rep.CGImage()
    if not cg_image:
        logger.error("❌ Failed to convert to CGImage.")
        return None

    return cg_image


def recognize_text_pyobjc(image_path,
                          recognition_level=Vision.VNRequestTextRecognitionLevelAccurate,
                          uses_language_correction=True):
    """Uses macOS Vision framework to extract text and barcode/QR code data from an image."""

    # Check if the file exists early
    if not os.path.exists(image_path):
        logger.error("❌ Image path does not exist: %s", image_path)
        return "", [], ""

    try:
        # Load the image using AppKit
        image = AppKit.NSImage.alloc().initWithContentsOfFile_(image_path)
        if not image:
            logger.error("❌ Failed to load image.")
            return "", [], ""

        # Log image size
        size = image.size()
        logger.info(f"Image size: {size.width} x {size.height}")

        # Convert NSImage to CGImage
        cg_image = nsimage_to_cgimage(image)
        if not cg_image:
            return "", [], ""

        # Create a text recognition request
        text_request = Vision.VNRecognizeTextRequest.alloc().init()
        text_request.setRecognitionLevel_(recognition_level)
        text_request.setUsesLanguageCorrection_(uses_language_correction)

        # Create a barcode detection request
        barcode_request = Vision.VNDetectBarcodesRequest.alloc().init()

        # Create an image request handler
        handler = Vision.VNImageRequestHandler.alloc().initWithCGImage_options_(cg_image, None)

        # Perform the requests
        success, error = handler.performRequests_error_([text_request, barcode_request], None)
        if not success:
            logger.error(f"❌ Vision OCR failed: {error}")
            return "", [], ""

        # Extract recognized text
        text_results = text_request.results()
        if not text_results:
            logger.info("No text detected.")
            extracted_text = "No text detected."
        else:
            extracted_text = "\n".join([result.text() for result in text_results])

        # Extract hashtags
        hashtags = extract_hashtags(extracted_text)

        # Extract barcode/QR code information
        barcode_info = extract_barcode_info(barcode_request.results())

        return extracted_text, hashtags, barcode_info

    except Exception as e:
        logger.error(f"❌ Error: {e}")
        return "", [], ""


def extract_hashtags(text):
    """Extracts hashtags from the given text."""
    # Regular expression to find hashtags (words starting with # followed by alphanumeric characters)
    hashtags = re.findall(r'#\w+', text)
    return hashtags


def extract_barcode_info(barcode_results):
    """Extracts barcode or QR code information from the detection results."""
    barcode_data = []
    for barcode in barcode_results:
        # Extract the string associated with the barcode
        if hasattr(barcode, 'payloadString'):
            data = barcode.payloadString()
            if data:
                barcode_data.append(data)
    logger.info("Barcode/QR code data: %s", barcode_data)
    return ', '.join(barcode_data) if barcode_data else ""


if __name__ == '__main__':
    image_path = 'scans/snap_2025-02-22_18-12-04-435736.png'
    extracted_text, hashtags, barcode_info = recognize_text_pyobjc(image_path)

    logger.info("Extracted Text:\n%s", extracted_text)
    logger.info("Hashtags found: %s", hashtags)
    logger.info("Barcode/QR code Info: %s", barcode_info)
