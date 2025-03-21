import serial

try:
    ser = serial.Serial(port="COM6", baudrate=625000, timeout=1)  # Replace COMx with your port
    print("Baud rate 625000 is supported!")
    ser.close()
except ValueError:
    print("Baud rate 625000 is NOT supported.")
