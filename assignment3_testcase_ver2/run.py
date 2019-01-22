import os
import sys
if (len(sys.argv) != 2):
	print "error!!"
	exit()
num = sys.argv[1]

for i in range(1):
	cmd = "../build/llvmassignment test" + str(num).zfill(2) + ".bc"
	os.system(cmd)
