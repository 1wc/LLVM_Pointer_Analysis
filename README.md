#### 1.更改$LLVM/tools/CMakeLists.txt，加入一行

先将项目程序目录放在 llvm/tools/ 路径下。

```
add_llvm_tool_subdirectory(llvm-assignment)  // 这个名字和子目录文件名一样
add_llvm_external_project(llvmassignment3)  // 名字和生成的可执行文件一样
```

#### 2.重新make

```
cd llvm/build
cmake -G "Unix Makefiles" your_llvm_path
make -j 8
```
