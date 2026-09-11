cmake_minimum_required(VERSION 3.20)

# ==========================================
# 1. TOOLCHAIN & COMPILER CONFIGURATION
# ==========================================
if(WIN32)
    set(CMAKE_C_COMPILER "C:/msys64/ucrt64/bin/gcc.exe")
    set(CMAKE_CXX_COMPILER "C:/msys64/ucrt64/bin/g++.exe")
endif()

project("CPP-Backend-Server" LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose Build Type" FORCE)
endif()

# ==========================================
# 2. VENDORED DEPENDENCIES
# ==========================================

# ==[ Drogon ]==============================

set(BUILD_TESTING OFF CACHE INTERNAL "" FORCE)
set(BUILD_EXAMPLES OFF CACHE INTERNAL "" FORCE)
set(BUILD_CTL OFF CACHE INTERNAL "" FORCE)
set(BUILD_REDIS OFF CACHE INTERNAL "" FORCE)
set(OLD_WARN_DEPRECATED ${CMAKE_WARN_DEPRECATED})
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE)
add_subdirectory(dep/drogon)
set(CMAKE_WARN_DEPRECATED ${OLD_WARN_DEPRECATED} CACHE BOOL "" FORCE)

# ==[ NitronServer ]========================

add_subdirectory(app)
