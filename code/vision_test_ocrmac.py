from ocrmac import ocrmac


# OCR test
def recognize_text_macos(image_path):
    annotations = ocrmac.OCR(image_path,
                             language_preference=['en-US'],
                             framework="livetext"
                             ).recognize()
    print(annotations)
    return annotations


if __name__ == '__main__':
    recognize_text_macos('scans/snap_2025-02-22_18-12-04-435736.png')
