## CUDA SMART POINTERS
[![build:passing](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/lkoshale/cuda-smart-pointers/)
A simple wrapper for ``` std::unique_ptr``` and ```std::shared_ptr```  for GPU on CUDA.

### How to build?
All definitions are in a single header file ```src/memory.cuh```,  you need to include it in your project.

### How to use?
```cpp
#include "memory.cuh"
// creates a gpu pointer of type int* with 10 elements
// and returns a std::shared_ptr encapsulating it
auto sptr1 = cuda::shared<int>(10);
//or
std::shared_ptr<int> sptr2 = cuda::shared<int>(10);
{
	// returns std::unique_ptr
	auto uptr = cuda::unique<float>(100);
} // deallocation when out of scope
 ```
 The header gives the following four functions to create valid GPU smart pointers:
 1. ```auto ptr = cuda::shared<TYPE>(NUM_ElEMENTS) //std::shared_ptr```
 2. ```auto ptr = cuda::unique<TYPE>(NUM_ElEMENTS) //std::unique_ptr```
 3. ```auto ptr = cuda::unified_shared<TYPE>(NUM_ElEMENTS) //std::shared_ptr```
 4.  ```auto ptr = cuda::unified_unique<TYPE>(NUM_ElEMENTS) //std::unique_ptr```
 
 1-2 creates pointers valid only on GPU, while 3-4 creates pointers valid on both CPU and GPU by using CUDA **unified memory**.
 
 ### Sample Program
 ```cpp
#include  <iostream>
#include  "memory.cuh"

int  main() {
// creates std::shared_ptr which hold GPU memory
auto ptr1 = cuda::shared<int>(1);
auto ptr2(ptr1);

// Returns the number of shared_ptr objects
// referring to the same managed object.
std::cout << "[4] ptr1 use count: " << ptr1.use_count() << std::endl;  // output: 2
std::cout << "[5] ptr2 use count: " << ptr2.use_count() << std::endl;  // output: 2

// Relinquishes ownership of ptr1 on the object
// and pointer becomes NULL
ptr1.reset();
std::cout << "ptr1 relinquishes ownership" << std::endl;
std::cout << "[6] ptr1 is " << ptr1.get() << std::endl	//output: 0x0000;
std::cout << "[7] ptr2 use count: " << ptr2.use_count() << std::endl; //output: 1

std::shared_ptr<int> ptr3;
{
	auto ptr4 = cuda::shared<int>(1);
	ptr3 = ptr4;
	std::cout << "[9] ptr3 use count: " << ptr3.use_count() << std::endl; //output: 2
	std::cout << "[10] ptr4 use count: " << ptr4.use_count() << std::endl; //ouput: 2
}// deallocates ptr4

std::cout << "[11] ptr3 use count: " << ptr3.use_count() << std::endl; //ouput: 1
return  0;
}
```
 
### Building Test programs
Requirements:
1. CUDA and C++ (std:11)
2. CMake (3.8+)
#### Linux
In the root directory of repository run:
```bash
./build.sh
```
It will build the executables at ```./build/src/test/```

#### Windows with msvc and CUDA
To Build the VS project:
1. Open cmake-gui and point the source code to repository's root directory, and build and binaries to repository root/build.
2. Click "Configure"
3. Select your **visual studio** version
4. Click "Configure"
5. Click  "Generate"

To Build and Run:
1. Open Project "Example.sln" in build directory
2. Right click the test app you want to run and click "Set as Startup Project"
3. Click "Build" from main menu, to build the project
4. Click "Debug"->"Start Without Debugging" to run and see the output.
