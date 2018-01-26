project(Foo VERSION 1.0.0 LANGUAGES CXX)

file(GLOB _HDRS "include/foo/*.hpp")
file(GLOB _SRCS "src/*.[hc]pp")

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
	VERSION ${PROJECT_VERSION}
	SOVERSION ${PROJECT_VERSION_MAJOR})
if(APPLE)
	set_target_properties(${PROJECT_NAME} PROPERTIES INSTALL_RPATH "@loader_path")
elseif(UNIX)
	set_target_properties(${PROJECT_NAME} PROPERTIES INSTALL_RPATH "$ORIGIN")
endif()
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
