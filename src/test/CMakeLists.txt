
set(SOURCE_HEADERS ../memory.cuh)

add_executable(unique unique.cu ${SOURCE_HEADERS})
#set_property(TARGET unique PROPERTY CUDA_ARCHITECTURES 40)

add_executable(shared shared.cu ${SOURCE_HEADERS})


add_executable(unified_shared unified_shared.cu ${SOURCE_HEADERS})


add_executable(unified_unique unified_unique.cu ${SOURCE_HEADERS})
