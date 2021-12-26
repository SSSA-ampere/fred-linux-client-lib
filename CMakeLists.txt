# sources: 
#    https://github.com/balister/meta-sdr/blob/master/recipes-support/gr-ais/gr-ais_git.bb
#    https://github.com/bistromath/gr-ais/blob/master/CMakeLists.txt
cmake_minimum_required(VERSION 3.12)
project(fred_lib LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# default installation path
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set (CMAKE_INSTALL_PREFIX "/opt/fredsys/"
           CACHE PATH "default install path" FORCE)
endif()

#select the release build type by default to get optimization flags
if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
   message(STATUS "Build type not specified: defaulting to release.")
endif(NOT CMAKE_BUILD_TYPE)
set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99 -Wall -Werror -fpic -DFRED_PATH=${CMAKE_INSTALL_PREFIX}")
#add_compile_definitions("-DFRED_PATH=${CMAKE_INSTALL_PREFIX}")
#add_compile_options("-std=gnu99 -Wall -Werror -fpic")

include_directories(
        ${CMAKE_CURRENT_SOURCE_DIR}/
)

add_library(fred SHARED
    fred_lib.c
    user_buff.c
)

add_library(fred_s STATIC
    fred_lib.c
    user_buff.c
)

set_target_properties(fred PROPERTIES PUBLIC_HEADER "fred_lib.h")
#set_target_properties(fred PROPERTIES DEFINE_SYMBOL "fred_EXPORTS")
set_target_properties(fred PROPERTIES SOVERSION "${VERSION_MAJOR}")
set_target_properties(fred PROPERTIES VERSION "${VERSION_MAJOR}.${VERSION_MINOR}")

install(FILES 
    ${CMAKE_CURRENT_BINARY_DIR}/libfred.so 
    ${CMAKE_CURRENT_BINARY_DIR}/libfred_s.a
         DESTINATION lib
)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/fred_lib.h
         DESTINATION include
)

########################################################################
# Install cmake search helper for this library
########################################################################
# install(FILES cmake/fredConfig.cmake
#     DESTINATION ${CMAKE_MODULES_DIR}/fred
# )