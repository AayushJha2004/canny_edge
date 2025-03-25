import serial

def send_pixels(serial_port, input_file, output_file, baudrate=312500):
    with serial.Serial(serial_port, baudrate=baudrate, bytesize=serial.EIGHTBITS,
                       parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, timeout=1) as ser:
        with open(input_file, 'rb') as infile, open(output_file, 'w') as outfile:
            i = 0  # Byte counter
            buffer = infile.read()  # Read all data at once
            ser.write(buffer)  # Send all data at once
            print(f"Transmitted {len(buffer)} bytes")  # Debug output

            received = ser.read(len(buffer))  # Read all received bytes
            for byte in received:
                binary_data = format(byte, '08b')
                outfile.write(f"{binary_data}\n")  # Write received data as binary

            print(f"Transmission complete. Received {len(received)} bytes")

if __name__ == "__main__":
    send_pixels("COM6", r"C:\Users\ROG\Desktop\canny_edge\testImages\images_binary\lena_gray.txt", 
                r"C:\Users\ROG\Desktop\canny_edge\testImages\output.txt")  # Change port as needed
