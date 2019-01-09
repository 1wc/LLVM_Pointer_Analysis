import os

cwd = os.getcwd()

for f in os.listdir(cwd):
    if f.startswith("test") and f.endswith(".c"):
       os.system("/home/liwc/llvm-5.0.0.src/build/bin/clang -emit-llvm -c -O0 -g3 " + f + " -o " + f.split(".")[0] + ".bc") 
       os.system("/home/liwc/llvm-5.0.0.src/build/bin/llvm-dis " + f.split(".")[0] + ".bc")
