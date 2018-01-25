project(FooApp VERSION 1.0.0 LANGUAGES CXX)

file(GLOB _SRCS "src/*.[hc]pp")
if(APPLE)
	set(_RPATH "@loader_path/../lib")
elseif(UNIX)
	set(_RPATH "$ORIGIN/../lib")
endif()

find_package(Cbc REQUIRED)

add_executable(${PROJECT_NAME} "")
target_sources(${PROJECT_NAME} PRIVATE ${_SRCS})
target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
set_target_properties(${PROJECT_NAME} PROPERTIES
	INSTALL_RPATH ${_RPATH}
	VERSION ${PROJECT_VERSION})
target_link_libraries(${PROJECT_NAME} PUBLIC
	Cbc::OsiCbc	Cbc::CbcSolver
	Clp::OsiClp	Clp::ClpSolver
	)
add_executable(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Test
include(CTest)
if(BUILD_TESTING)
	add_test(NAME FooApp_UT COMMAND FooApp)
endif()

# Install
install(TARGETS	FooApp
	EXPORT FooTargets
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
