import cv2
import webbrowser
import time

def show_image_with_message(image_path, message, timeout=5, url=None):
    """Display image with a centered success message using OpenCV."""
    # Read the image using OpenCV
    img = cv2.imread(image_path)

    if img is None:
        print("Error: Unable to load image.")
        return

    # Get image dimensions (height, width)
    height, width, _ = img.shape

    # Add a text overlay with the success message
    font = cv2.FONT_HERSHEY_SIMPLEX
    font_scale = 1.5
    font_thickness = 3  # Thicker text for a "bold" effect
    text_size = cv2.getTextSize(message, font, font_scale, font_thickness)[0]

    # Calculate the position to center the text
    text_x = (width - text_size[0]) // 2
    text_y = (height + text_size[1]) // 2

    # Add the text to the image with black color for the text (for a "bold" effect)
    cv2.putText(img, message, (text_x, text_y), font, font_scale, (0, 0, 0), font_thickness, lineType=cv2.LINE_AA)

    # Display the image with the message
    cv2.imshow("Success", img)

    # Wait for the specified timeout (in milliseconds)
    cv2.waitKey(timeout * 1000)  # Convert seconds to milliseconds
    cv2.destroyAllWindows()

    # If a URL is provided, open it in the default browser
    if url:
        webbrowser.open(url)

# Example usage
if __name__ == "__main__":
    image_path = "scans/detected_markers.png"  # Replace with your actual image path
    success_message = "✅ Scan Completed Successfully!"
    url_to_open = "https://pinry.petau.net"  # URL to open after timeout

    # Show the image with the success message and open the URL after 5 seconds
    show_image_with_message(image_path, success_message, timeout=5, url=url_to_open)
