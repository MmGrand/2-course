cmake_minimum_required(VERSION 3.10)
project(pc C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_FLAGS "-O0 -Wall -g")

include_directories(includes)
#[[
for lib path
set(CMAKE_CXX_FLAGS "-O0 -Wall -g -lTerm -lReadKey -lBigChars -lMemory")
]]

add_library(BigChars STATIC src/bigChars.c)
target_include_directories(BigChars PUBLIC ${PROJECT_SOURCE_DIR}/include)
add_library(Cpu STATIC src/cpu.c)
target_include_directories(Cpu PUBLIC ${PROJECT_SOURCE_DIR}/include)
add_library(Memory STATIC src/memory.c)
target_include_directories(Memory PUBLIC ${PROJECT_SOURCE_DIR}/include)
add_library(ReadKey STATIC src/readKey.c)
target_include_directories(ReadKey PUBLIC ${PROJECT_SOURCE_DIR}/include)
add_library(Term STATIC src/term.c)
target_include_directories(Term PUBLIC ${PROJECT_SOURCE_DIR}/include)
add_library(Signals STATIC src/signals.c)
target_include_directories(Signals PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(ASM STATIC src/asm.c)
target_include_directories(ASM PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(BSC STATIC src/basic.c)
target_include_directories(BSC PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(RPN STATIC src/rpn.c)
target_include_directories(RPN PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(CPU STATIC src/cpu.c)
target_include_directories(CPU PUBLIC ${PROJECT_SOURCE_DIR}/include)


add_executable(pc main.c src/ui.c)

#[[
for lib path
target_link_libraries(pc ${CMAKE_SOURCE_DIR}/lib/libTerm.a)
target_link_libraries(pc ${CMAKE_SOURCE_DIR}/lib/libReadKey.a)
target_link_libraries(pc ${CMAKE_SOURCE_DIR}/lib/libBigChars.a)
target_link_libraries(pc ${CMAKE_SOURCE_DIR}/lib/libMemory.a)
]]

target_link_libraries(pc PRIVATE BigChars)
target_link_libraries(pc PRIVATE Memory)
target_link_libraries(pc PRIVATE ReadKey)
target_link_libraries(pc PRIVATE Term)
target_link_libraries(pc PRIVATE Signals)
target_link_libraries(pc PRIVATE ASM)
target_link_libraries(pc PRIVATE BSC)
target_link_libraries(pc PRIVATE RPN)
target_link_libraries(pc PRIVATE CPU)