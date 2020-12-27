cmake_minimum_required(VERSION 3.10)
project (pcTests)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_FLAGS "-O0 -Wall -g")

include_directories(includes)
#[[
for lib path
set(CMAKE_CXX_FLAGS "-O0 -Wall -g -lTerm -lBigChars -lMemory")
]]

add_library(BigChars STATIC ../src/bigChars.c)
target_include_directories(BigChars PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(Memory STATIC ../src/memory.c)
target_include_directories(Memory PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(Term STATIC ../src/term.c)
target_include_directories(Term PUBLIC ${PROJECT_SOURCE_DIR}/include)

add_library(Tests STATIC tests.c)
target_include_directories(Tests PUBLIC ${PROJECT_SOURCE_DIR}/tests)


add_executable(tests main.c)


#[[
for lib path
target_link_libraries(tests ${CMAKE_SOURCE_DIR}/lib/libTests.a)
target_link_libraries(tests ${CMAKE_SOURCE_DIR}/lib/libBigChars.a)
target_link_libraries(tests ${CMAKE_SOURCE_DIR}/lib/libMemory.a)
target_link_libraries(pc ${CMAKE_SOURCE_DIR}/lib/libTerm.a)
]]

target_link_libraries(tests PRIVATE BigChars)
target_link_libraries(tests PRIVATE Memory)
target_link_libraries(tests PRIVATE Term)
target_link_libraries(tests PRIVATE Tests)

