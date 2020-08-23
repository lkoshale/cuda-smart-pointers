
#include <iostream>

#include "memory.cuh"

int main() {
    // creates std::unique_ptr which hold GPU unified memory
    auto ptr1 = cuda::unified_unique<int>(1);
    std::cout << "[1] ptr1 is " << ptr1.get() << std::endl;

    *ptr1 = 100;
    std::cout << "[2] Value of *ptr1 is: " << *ptr1 << std::endl;

    std::cout << "transfering ownership to ptr2" << std::endl;
    auto ptr2 = std::move(ptr1);
    std::cout << "[3] ptr1 is " << ptr1.get() << std::endl;
    std::cout << "[4] ptr2 is " << ptr2.get() << std::endl;

    std::cout << "transfering ownership to ptr3" << std::endl;
    auto ptr3 = std::move(ptr2);
    std::cout << "[5] ptr1 is " << ptr1.get() << std::endl;
    std::cout << "[6] ptr2 is " << ptr2.get() << std::endl;
    std::cout << "[7] ptr3 is " << ptr3.get() << std::endl;
    std::cout << "[8] Value of *ptr3 is: " << *ptr3 << std::endl;

    return 0;
}
