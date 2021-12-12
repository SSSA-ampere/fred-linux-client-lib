cmake_minimum_required(VERSION 3.0)
project(fred_lib LANGUAGES C)

set(FRED_PATH "/opt/fredsys")

set(CMAKE_C_FLAGS "-std=gnu99 -O2 -Wall -Werror -fpic -DFRED_PATH=${FRED_PATH}")

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

INSTALL(TARGETS fred fred_s
        DESTINATION ${FRED_PATH}
        LIBRARY DESTINATION ${FRED_PATH}/lib
        ARCHIVE DESTINATION ${FRED_PATH}/lib
        PUBLIC_HEADER DESTINATION ${FRED_PATH}/include
)
