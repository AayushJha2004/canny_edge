import os
import numpy as np
from PIL import Image

def convert_image_to_8bit(image_path):
    """Converts a grayscale image to an 8-bit image."""
    img = Image.open(image_path).convert('L')  # Convert to grayscale
    np_img = np.array(img)  # Get the pixel values as a NumPy array
    return np_img

def save_binary_image(binary_img, output_path):
    """Saves the 8-bit grayscale image as a .bin file."""
    binary_img.tofile(output_path)

def process_images(input_folder, output_folder):
    """Process all PNG images in the input folder and save them as binary files."""
    # Ensure the output folder exists
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Loop through all files in the input folder
    for filename in os.listdir(input_folder):
        if filename.endswith('.png'):
            image_path = os.path.join(input_folder, filename)
            binary_img = convert_image_to_8bit(image_path)
            
            # Prepare the output file path
            output_filename = os.path.splitext(filename)[0] + '.txt'
            output_path = os.path.join(output_folder, output_filename)
            
            # Save the 8-bit grayscale image
            save_binary_image(binary_img, output_path)
            print(f"Converted {filename} to 8-bit grayscale binary and saved to {output_filename}")

# Example usage:
input_folder = '/Users/aayush/Desktop/canny_edge/testImages/images_grayscale'  # Replace with your input folder path
output_folder = '/Users/aayush/Desktop/canny_edge/testImages/images_binary'  # Replace with your output folder path

process_images(input_folder, output_folder)