cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project(Example LANGUAGES CUDA CXX)

if(NOT DEFINED CMAKE_CUDA_STANDARD)
    set(CMAKE_CUDA_STANDARD 11)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

set(CMAKE_CUDA_ARCHITECTURES 35)

include_directories(src)
add_subdirectory(src)
