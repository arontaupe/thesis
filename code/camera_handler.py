import tkinter as tk
from PIL import Image, ImageTk, ImageEnhance
import cv2
import time
import os


def scan(image_path=None, camera_index=None, hold_preview=False, preview_scale=1.0, timeout=10):
    """
    Captures an image with a beautiful, high-quality Tkinter preview.
    Features a centered, large countdown before capture.
    """
    assert image_path is not None, "Image path not provided."

    if camera_index is None:
        camera_index = 0  # Default camera index

    # Open camera
    camera = cv2.VideoCapture(camera_index)
    if not camera.isOpened():
        print("❌ Error: Could not access the webcam")
        return None, None

    # Get highest available resolution
    camera.set(cv2.CAP_PROP_FRAME_WIDTH, 9999)
    camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 9999)

    max_width = int(camera.get(cv2.CAP_PROP_FRAME_WIDTH))
    max_height = int(camera.get(cv2.CAP_PROP_FRAME_HEIGHT))

    print(f"🔍 Using resolution: {max_width}x{max_height}")

    # Calculate preview dimensions
    preview_width = int(max_width * preview_scale)
    preview_height = int(max_height * preview_scale)

    # Initialize Tkinter window
    root = tk.Tk()
    root.title("📸 Capture Preview")
    root.geometry(f"{preview_width}x{preview_height}")  # Adjust to preview size
    root.configure(bg="black")
    root.overrideredirect(True)  # Borderless fullscreen effect

    # Create canvas for overlay
    canvas = tk.Canvas(root, width=preview_width, height=preview_height, highlightthickness=0)
    canvas.pack()

    countdown_label = tk.Label(root, text="4", font=("Helvetica", 100, "bold"), fg="white", bg="black")
    countdown_label.place(x=preview_width // 2, y=preview_height // 2, anchor="center")  # Center countdown

    frame = None
    countdown_start = time.time()

    def update_preview():
        """Update the camera preview & countdown."""
        nonlocal frame

        ret, frame = camera.read()
        if not ret:
            print("❌ Error: Failed to read from camera.")
            root.destroy()
            return

        # Scale down only for preview
        frame_preview = cv2.resize(frame, (preview_width, preview_height))

        frame_rgb = cv2.cvtColor(frame_preview, cv2.COLOR_BGR2RGB)
        img = Image.fromarray(frame_rgb)

        # Apply slight dimming effect
        enhancer = ImageEnhance.Brightness(img)
        img = enhancer.enhance(0.6)

        img_tk = ImageTk.PhotoImage(img)
        canvas.create_image(0, 0, anchor=tk.NW, image=img_tk)
        canvas.img_tk = img_tk  # Keep reference

        # Update countdown timer
        elapsed = int(time.time() - countdown_start)
        remaining = max(0, 4 - elapsed)
        countdown_label.config(text=str(remaining - 1))

        if remaining == 0:
            capture()  # Capture automatically at 0

        root.after(100, update_preview)

    def capture(event=None):
        """Capture image and close window."""
        nonlocal frame
        if frame is not None:
            cv2.imwrite(image_path, frame)
            print(f"✅ Image saved: {image_path}")
        camera.release()
        root.quit()

    def check_timeout():
        """Exit if hold_preview is enabled and timeout is reached."""
        if hold_preview and time.time() - countdown_start > timeout:
            print("⌛ Timeout reached. Exiting...")
            root.quit()
        root.after(1000, check_timeout)

    # Bind Enter key to capture function
    root.bind("<Return>", capture)

    # Start preview loop
    update_preview()
    check_timeout()
    root.mainloop()

    return frame, image_path if os.path.exists(image_path) else (None, None)


if __name__ == '__main__':
    scan("./scans/debug_img.png", hold_preview=False, preview_scale=0.5, timeout=10)
