set(BUILD_SHARED_LIBS OFF)
set(BUILD_TESTING OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Backup the value of CMAKE_SKIP_INSTALL_RULES
set(_SKIP_INSTALL ${CMAKE_SKIP_INSTALL_RULES})
# TODO Keep install rules of dependencies (and adapt them if needed)
#set(CMAKE_SKIP_INSTALL_RULES TRUE)

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
	${CMAKE_BINARY_DIR}/zlib-build
	EXCLUDE_FROM_ALL)
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
	${CMAKE_BINARY_DIR}/cbc-build
	EXCLUDE_FROM_ALL)
message(STATUS "Subproject: COIN-OR:Cbc...DONE")

set(CMAKE_SKIP_INSTALL_RULES ${_SKIP_INSTALL})
