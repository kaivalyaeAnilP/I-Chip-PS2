from PIL import Image

im = Image.open('C:/Users/Kaivalya/Downloads/ps2_pic.jpg')

pixels = list(im.getdata())
width, height = 256,256 
pixels_int = [int(x) for x in pixels]
pixels_hex = [hex(x) for x in pixels_int]

pixels_hex = [x.replace("0x","") for x in pixels_hex]

with open("C:/Users/Kaivalya/Documents/ps2_pic.txt", "w") as f:
    f.writelines(["%s\n" % item  for item in pixels_hex])
f.close()
