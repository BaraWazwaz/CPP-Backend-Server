cmake_minimum_required(VERSION 3.20)
project(MyDrogonApp)

set(CMAKE_CXX_STANDARD 23) # Matching your JSON

# 1. Add the drogon submodule directory
add_subdirectory(drogon)

add_executable(MyDrogonApp main.cpp)

# 2. Link your app to Drogon (this automatically shares include paths)
target_link_libraries(MyDrogonApp PRIVATE Drogon::Drogon)
