project(Foo VERSION 1.0.0 LANGUAGES CXX)

file(GLOB _HDRS "include/foo/*.hpp")
file(GLOB _SRCS "src/*.[hc]pp")
if(APPLE)
	set(_RPATH "@loader_path/../lib")
elseif(UNIX)
	set(_RPATH "$ORIGIN/../lib")
endif()

find_package(Cbc REQUIRED)

add_library(${PROJECT_NAME} "")
target_sources(${PROJECT_NAME} PRIVATE ${_HDRS} ${_SRCS})
target_include_directories(${PROJECT_NAME} PUBLIC
	$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:include>
	)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
set_target_properties(${PROJECT_NAME} PROPERTIES
	PUBLIC_HEADER ${_HDRS}
	INSTALL_RPATH ${_RPATH}
	VERSION ${PROJECT_VERSION}
	SOVERSION ${PROJECT_VERSION_MAJOR})
target_link_libraries(${PROJECT_NAME} PUBLIC
	Cbc::OsiCbc	Cbc::CbcSolver
	Clp::OsiClp	Clp::ClpSolver
	)
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Install
install(TARGETS	Foo
	EXPORT FooTargets
	PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/foo
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	)
