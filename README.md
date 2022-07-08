We use Verilog to implement A/5 encryption on a 256x256 pixel grayscale .jpg image.
First, we create 18 bit, 22 bit, and 23 bit shift registers in Verilog.  Next, we create a Verilog test bench, split the image into eight planes, taking one bit per plane from each image byte. Variable j(varied from 0 to 7) is used for indexing the planes.
For each iteration of j, the 3 registers are set to 0, initialized with the 64 bit public and 22 bit private keys, and then clocked for 100 cycles.
Each bit of the 256x256 image plane is then XORed with the output of the 3 registers, using majority logic.  After a total of 64+22+100+65536 = 65722 cycles, the plane has been completely encrypted.
Now j is incremented and the process repeats.  When j attains a value of 8, the process ends, and the entire image has now been encrypted.  A/5 is a symmetric encryption algorithm, so applying the same process to the encrypted image gives us back the original image.
