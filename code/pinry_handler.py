import requests
import urllib.parse
from logger_config import logger

# Pinry Configuration
PINRY_URL = "https://pinry.petau.net/api/v2"

import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

PINRY_TOKEN = os.getenv("PINRY_TOKEN")
HEADERS = {"Authorization": f"Token {PINRY_TOKEN}"}


def upload_image_to_pinry(image_path):
    """Uploads an image to Pinry and returns the image ID."""
    with open(image_path, "rb") as image_file:
        files = {"image": image_file}
        response = requests.post(f"{PINRY_URL}/images/", headers=HEADERS, files=files)

        if response.status_code == 201:
            image_id = response.json()['id']
            logger.info(f"✅ Image uploaded, ID: {image_id}")
            return image_id
        else:
            logger.error(f"❌ Image upload failed: {response.text}")
            return None


def create_pin_with_image(image_id, tags, source_url=None, description=""):
    """Creates a Pin with an uploaded image using image_by_id and assigns tags."""
    # URL encode the source URL

    if description is None:
        description = ""

    description = f"{description}\n\nSource: {source_url}" if source_url else description

    data = {
        "image_by_id": image_id,  # Use image_by_id instead of image
        # "url": encoded_url,  # Send URL in the `url` field
        # url always gives error 500
        "description": description,  # add to description instead
        "tags": tags,  # List of tags to associate with the pin
    }

    logger.info(f"Creating pin with source URL: {source_url}")

    response = requests.post(
        f"{PINRY_URL}/pins/",
        headers={**HEADERS, "Content-Type": "application/json"},
        json=data  # Send the data as JSON
    )

    if response.status_code == 500:
        logger.error(f"❌ 500 error: {response.text}")  # Log the full response in case of a 500 error
        return None, None

    logger.debug(f"Pin creation response: {response.text}")  # Log the full response for debugging

    if response.status_code == 201:
        pin_id = response.json()['id']
        pin_url = response.json().get('resource_link')  # Fetch the pin URL from the response
        clickable_url = pin_url.replace("api/v2/", "")  # Clean up the URL
        logger.info(f"✅ Pin created: {clickable_url}")
        return pin_id, clickable_url
    else:
        logger.error(f"❌ Pin creation failed: {response.text}")
        return None, None


def upload_and_create_pin(image_path, board_id, tags, source_url=None, description=""):
    """Wrapper function to upload an image and create a pin with tags and source URL."""
    image_id = upload_image_to_pinry(image_path)

    if image_id:
        pin_id, pin_url = create_pin_with_image(image_id, tags, source_url, description)

        if pin_id and pin_url:
            add_pin_to_board(pin_id, board_id)
            return pin_url

    return None


def add_pin_to_board(pin_id, board_id):
    """Adds an existing pin to a specific board."""
    data = {"pins_to_add": [pin_id]}  # Board update, adding the pin to the board
    response = requests.patch(f"{PINRY_URL}/boards/{board_id}/", headers=HEADERS, data=data)

    if response.status_code == 200:
        logger.info(f"✅ Pin added to board {board_id}")
    else:
        logger.error(f"❌ Failed to add pin to board: {response.text}")


if __name__ == "__main__":
    image_path = "scans/snap_2025-02-24_13-42-29-257.png"
    board_id = 2  # Your board ID
    tags = ["example_tag", "another_tag"]
    source_url = "https://archive.petau.net/#/page/Upload%202025-02-24%2019%3A23%3A23"  # Example source URL
    description = "My captured image"

    pin_url = upload_and_create_pin(image_path, board_id, tags, source_url, description)

    if pin_url:
        logger.info(f"✅ Pin URL: {pin_url}")
    else:
        logger.error("❌ Pin creation failed.")
