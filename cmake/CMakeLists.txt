set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_TESTING OFF)

############
##  ZLIB  ##
############
message(STATUS "Subproject: ZLIB...")
# Download and unpack zlib at configure time
configure_file(
	${CMAKE_CURRENT_SOURCE_DIR}/zlib.CMakeLists.txt
	${CMAKE_BINARY_DIR}/zlib-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/zlib-download)
if(result)
  message(FATAL_ERROR "CMake step for zlib failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/zlib-download)
if(result)
  message(FATAL_ERROR "Build step for zlib failed: ${result}")
endif()

add_subdirectory(
	${CMAKE_BINARY_DIR}/zlib-src
	${CMAKE_BINARY_DIR}/zlib-build)
message(STATUS "Subproject: ZLIB...DONE")

###################
##  COIN-OR:CBC  ##
###################
message(STATUS "Subproject: COIN-OR:Cbc...")
# Download and unpack cbc at configure time
configure_file(
	${CMAKE_CURRENT_SOURCE_DIR}/cbc.CMakeLists.txt
	${CMAKE_BINARY_DIR}/cbc-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/cbc-download)
if(result)
  message(FATAL_ERROR "CMake step for cbc failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/cbc-download)
if(result)
  message(FATAL_ERROR "Build step for cbc failed: ${result}")
endif()

add_subdirectory(
	${CMAKE_BINARY_DIR}/cbc-src
	${CMAKE_BINARY_DIR}/cbc-build)
message(STATUS "Subproject: COIN-OR:Cbc...DONE")
