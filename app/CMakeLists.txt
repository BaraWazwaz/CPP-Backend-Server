# ============================================================================
# TARGET 1: NitronServerLib (Independent, Transferable Library)
# ============================================================================

# Automatically gather implementation files inside the lib directory
file(GLOB_RECURSE LIB_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/lib/*.cpp")

# Define the static library target
add_library(NitronServerLib STATIC ${LIB_SOURCES})

# Export your include directory so consumers automatically get the header paths
target_include_directories(NitronServerLib 
    PUBLIC 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# Link Drogon publicly so any project consuming your library inherits Drogon's headers too
target_link_libraries(NitronServerLib PUBLIC Drogon::Drogon)


# ============================================================================
# TARGET 2: NitronServer (The Core Runtime Executable)
# ============================================================================

add_executable(NitronServer src/main.cpp)

# Link your internal core logic library privately
target_link_libraries(NitronServer PRIVATE NitronServerLib)


# ============================================================================
# TARGET 3: NitronServerTest (The Testing Suite Executable)
# ============================================================================

add_executable(NitronServerTest "${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp")

# Link your internal core logic library privately
target_link_libraries(NitronServerTest PRIVATE NitronServerLib)


# ============================================================================
# UNIVERSAL COMPILER OPTIMIZATIONS & DEPLOYMENT SETTINGS
# ============================================================================
include(CheckIPOSupported)
check_ipo_supported(RESULT ipo_supported OUTPUT ipo_error LANGUAGES CXX)

# Create an array list of all your targets to clean up configuration code repetition
set(ALL_APP_TARGETS NitronServerLib NitronServer NitronServerTest)

foreach(target IN LISTS ALL_APP_TARGETS)
    # Map compilation definitions cleanly across all scopes
    target_compile_definitions(${target} PRIVATE
        $<$<CONFIG:Debug>:DEVELOPMENT_MODE=1>
        $<$<CONFIG:Release>:NDEBUG>
    )

    # Set warnings and optimization rules per compilation profile
    target_compile_options(${target} PRIVATE
        $<$<CONFIG:Debug>:-Wall -Wextra -Wpedantic>
        $<$<CONFIG:Release>:-O3>
    )

    # Enable Link Time Optimization (LTO) solely for Release profiles
    if(ipo_supported)
        set_target_properties(${target} PROPERTIES INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
    endif()
endforeach()

# Apply static runtime linking flags to the binary executables for portability
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    target_link_options(NitronServer PRIVATE "-static-libgcc" "-static-libstdc++")
    target_link_options(NitronServerTest PRIVATE "-static-libgcc" "-static-libstdc++")
endif()
