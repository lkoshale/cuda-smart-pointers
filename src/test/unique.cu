
#include <iostream>

#include "memory.cuh"

int main() {
    // creates std::unique_ptr which holds GPU memory
    auto ptr1 = cuda::unique<int>(1);
    std::cout << "[1] ptr1 is " << ptr1.get() << std::endl;

    std::cout << "transfering ownership to ptr2" << std::endl;
    auto ptr2 = std::move(ptr1);
    std::cout << "[2] ptr1 is " << ptr1.get() << std::endl;
    std::cout << "[3] ptr2 is " << ptr2.get() << std::endl;

    std::cout << "transfering ownership to ptr3" << std::endl;
    auto ptr3 = std::move(ptr2);
    std::cout << "[4] ptr1 is " << ptr1.get() << std::endl;
    std::cout << "[5] ptr2 is " << ptr2.get() << std::endl;
    std::cout << "[6] ptr3 is " << ptr3.get() << std::endl;

    return 0;
}
