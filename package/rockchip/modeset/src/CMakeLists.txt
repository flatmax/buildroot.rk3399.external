# vim: syntax=cmake
cmake_minimum_required(VERSION 2.8.11)

include_directories(.)
include_directories("/home/asx/linux/3128h/buildroot/output/host/usr/arm-rockchip-linux-gnueabihf/sysroot/usr/include" "/home/asx/linux/3128h/buildroot/output/host/usr/arm-rockchip-linux-gnueabihf/sysroot/usr/include/libdrm")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")

link_libraries("libdrm.so")
link_libraries("libjpeg.so")
link_libraries("libpthread.so")
ADD_DEFINITIONS(-fpermissive)
set(BOOT_SET_H
	drm_common.h
    bootanimation.h
)
add_executable(modeset
    bootanimation.cpp
	drm_common.cpp
    modeset.cpp
    )

INSTALL(TARGETS modeset RUNTIME DESTINATION bin)
