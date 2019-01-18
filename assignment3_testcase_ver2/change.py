import os

cwd = os.getcwd()

for f in os.listdir(cwd):
    if f.startswith("test") and f.endswith(".c"):
       os.system("clang -emit-llvm -c -O0 -g3 " + f + " -o " + f.split(".")[0] + ".bc") 
       os.system("llvm-dis " + f.split(".")[0] + ".bc")
