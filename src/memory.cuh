#ifndef MEMORY_CUH
#define MEMORY_CUH

#include <memory>

namespace cuda {

#define checkErrors(ans) \
    { cudaAssert((ans), __FILE__, __LINE__); }
inline void cudaAssert(cudaError_t code, const char* file, int line, bool abort = true) {
    if (code != cudaSuccess) {
        fprintf(stderr, "gpuError: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}

template <class T>
T* cuMalloc(size_t size) {
    T* ptr;
    checkErrors(cudaMalloc((void**)&ptr, size));
    return ptr;
}

template <class T>
T* cuMallocManaged(size_t size) {
    T* ptr;
    checkErrors(cudaMallocManaged(&ptr, size));
    return ptr;
}

template <class T>
struct cuDeleter {
    void operator()(T* ptr) { checkErrors(cudaFree(ptr)); }
};

template <class T>
std::shared_ptr<T> shared(long long int numElements) {
    return std::shared_ptr<T>(cuMalloc<T>(sizeof(T) * numElements), cuDeleter<T>());
}

template <class T>
std::unique_ptr<T, cuDeleter<T>> unique(long long int numElements) {
    return std::unique_ptr<T, cuDeleter<T>>(cuMalloc<T>(sizeof(T) * numElements), cuDeleter<T>());
}

template <class T>
std::shared_ptr<T> unified_shared(long long int numElements) {
    return std::shared_ptr<T>(cuMallocManaged<T>(sizeof(T) * numElements), cuDeleter<T>());
}

template <class T>
std::unique_ptr<T, cuDeleter<T>> unified_unique(long long int numElements) {
    return std::unique_ptr<T, cuDeleter<T>>(cuMallocManaged<T>(sizeof(T) * numElements),
                                            cuDeleter<T>());
}

}  // namespace cuda

#endif
