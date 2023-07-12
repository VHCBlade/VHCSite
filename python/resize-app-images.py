from PIL import Image
import os

directories = [
    'assets/img/apps/'
]

for directory in directories:
    fullPath = os.getcwd() + '/' + directory
    for filename in os.listdir(fullPath):
        print("Resizing " + fullPath + filename + "...")
        image = Image.open(fullPath + filename)

        resized = image.resize((512, 512))

        resized.save(fullPath + filename)
