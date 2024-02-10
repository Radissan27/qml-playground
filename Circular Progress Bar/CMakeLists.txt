cmake_minimum_required (VERSION 3.10.2)

project (CircularProgressBar)
message(STATUS "Building project: ${PROJECT_NAME}")

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++17")

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/include AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/src)
    include_directories(include src)
else()
    message(FATAL_ERROR "The \"include\" and/or \"src\" folder/s do not exist!")
endif()

file(
    GLOB src 
    "include/*.h"
    "src/*.cpp"
)

add_executable(CircularProgressBar ${src})
