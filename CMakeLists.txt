cmake_minimum_required(VERSION 3.20)
project(LearningGitSubmodules CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --- TRACKING OPTIMIZATIONS FOR SUBMODULE ---
# 1. Disable Drogon's internal unit testing suite
set(BUILD_TESTING OFF CACHE INTERNAL "" FORCE)

# 2. Disable Drogon's internal sample and example binaries
set(BUILD_EXAMPLES OFF CACHE INTERNAL "" FORCE)

# 3. Disable building drogon_ctl (the tool that caused your example build crash)
set(BUILD_CTL OFF CACHE INTERNAL "" FORCE)

# 4. Optional: Strip out unused database drivers if you don't use them
set(BUILD_POSTGRESQL OFF CACHE INTERNAL "" FORCE)
set(BUILD_MYSQL OFF CACHE INTERNAL "" FORCE)
set(BUILD_SQLITE3 OFF CACHE INTERNAL "" FORCE)

# Include the submodule folder after setting the optimization switches
add_subdirectory(dep/drogon)

# Your executable engine definitions
add_executable(LearningGitSubmodules main.cpp)
target_link_libraries(LearningGitSubmodules PRIVATE Drogon::Drogon)
