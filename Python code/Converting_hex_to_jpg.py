from PIL import Image

with open(r'C:\Users\Kaivalya\project_2\project_2.sim\sim_1\behav\xsim\Encrypted_image.hex') as f:
    contents = f.read()
f.close()

contents = contents.replace(' ','')
contents = contents.replace('\n','')
print(contents)

data = bytes.fromhex(contents)

img = Image.frombytes("L", (256, 256), data)
img.save(r"C:\Users\Kaivalya\Pictures\Encrypted_image.jpg")
