output=open("cbm-map.txt", "wb")

replacements = {
b'\xff': bytes.fromhex('6d'),
b'\\': bytes.fromhex('4d'),
b'!': bytes.fromhex('74'),
b'[': bytes.fromhex('24'),
b'@': bytes.fromhex('2e'),
b'_': bytes.fromhex('45'),
b'-': bytes.fromhex('44'),
}

with open("usa-map.seq", "rb") as f:
    byte = f.read(1)
    while byte != b"":
        print(byte)
        if byte in replacements.keys():
            output.write(replacements[byte])
        elif byte == b'\r':
        	pass
        else:
            output.write(byte)
        byte = f.read(1)
