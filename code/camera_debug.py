import cv2

camera = cv2.VideoCapture(0)  # Change index if needed

if not camera.isOpened():
    print("❌ Could not access the webcam")
else:
    # Try setting 4K resolution
    camera.set(cv2.CAP_PROP_FRAME_WIDTH, 3840)
    camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 2160)

    # Read the actual resolution
    actual_width = int(camera.get(cv2.CAP_PROP_FRAME_WIDTH))
    actual_height = int(camera.get(cv2.CAP_PROP_FRAME_HEIGHT))

    print(f"Requested: 3840x2160 → Camera Output: {actual_width}x{actual_height}")

    ret, frame = camera.read()
    if ret:
        print(f"Captured frame size: {frame.shape[1]}x{frame.shape[0]}")
        cv2.imwrite("./debug_img.png", frame)

    camera.release()
