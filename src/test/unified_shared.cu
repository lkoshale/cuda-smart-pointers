
#include <iostream>

#include "memory.cuh"

int main() {
    // creates std::unique_ptr which hold GPU memory
    auto ptr1 = cuda::unified_shared<int>(1);
    std::cout << "[1] ptr1 is " << ptr1.get() << std::endl;

    auto ptr2(ptr1);
    std::cout << "transfering ownership to ptr2" << std::endl;
    std::cout << "[2] ptr1 is " << ptr1.get() << std::endl;
    std::cout << "[3] ptr2 is " << ptr2.get() << std::endl;

    // Returns the number of shared_ptr objects
    // referring to the same managed object.
    std::cout << "[4] ptr1 use count: " << ptr1.use_count() << std::endl;
    std::cout << "[5] ptr2 use count: " << ptr2.use_count() << std::endl;

    // Relinquishes ownership of p1 on the object
    // and pointer becomes NULL
    ptr1.reset();
    std::cout << "ptr1 relinquishes ownership" << std::endl;
    std::cout << "[6] ptr1 is " << ptr1.get() << std::endl;
    std::cout << "[7] ptr2 use count: " << ptr2.use_count() << std::endl;
    std::cout << "[8] ptr2 is " << ptr2.get() << std::endl;

    return 0;
}
