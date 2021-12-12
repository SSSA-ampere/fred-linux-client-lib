message("Found FRED.")
#project(fred VERSION 1.0 DESCRIPTION "FRED runtime for Zynq FPGA offloading")

set(CMAKE_C_FLAGS "-std=gnu99 -O2 -Wall -Werror -fpic ")

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
