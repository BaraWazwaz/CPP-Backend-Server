cmake_minimum_required(VERSION 3.20)
project(LearningGitSubmodules CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Optimization toggles we set up earlier
set(BUILD_TESTING OFF CACHE INTERNAL "" FORCE)
set(BUILD_EXAMPLES OFF CACHE INTERNAL "" FORCE)
set(BUILD_CTL OFF CACHE INTERNAL "" FORCE)


# --- FIX DEPRECATION WARNINGS WITHOUT CHANGING SUBMODULES ---
# 1. Save your current warning state
set(OLD_WARN_DEPRECATED ${CMAKE_WARN_DEPRECATED})

# 2. Turn OFF warnings globally before loading external code
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE)

# 3. Include the untouched submodule directory safely
add_subdirectory(dep/drogon)

# 4. Restore your project's warning state for your own code
set(CMAKE_WARN_DEPRECATED ${OLD_WARN_DEPRECATED} CACHE BOOL "" FORCE)
# -------------------------------------------------------------


add_executable(MyServer main.cpp)
target_link_libraries(MyServer PRIVATE Drogon::Drogon)
