
#include <iostream>

#include "memory.cuh"

int main() {
    // creates std::unique_ptr which hold GPU memory
    auto ptr1 = cuda::shared<int>(1);
    std::cout << "[1] ptr1 is " << ptr1.get() << std::endl;

    auto ptr2(ptr1);
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

    std::shared_ptr<int> ptr3;
    {
        auto ptr4 = cuda::shared<int>(1);
        ptr3      = ptr4;
        std::cout << "[9] ptr3 use count: " << ptr3.use_count() << std::endl;
        std::cout << "[10] ptr4 use count: " << ptr4.use_count() << std::endl;
    }
    std::cout << "[11] ptr3  use count: " << ptr3.use_count() << std::endl;

    return 0;
}
