# This file is just an orchestration
cmake_minimum_required(VERSION 3.8.2)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Set default build type to Release if empty.
set(CMAKE_BUILD_TYPE "Release" CACHE STRING
	"Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel.")

# Use find_package everywhere, no-op if it's a target
macro(find_package)
	if(NOT TARGET ${ARGV0} AND NOT TARGET ${ARGV0}::${ARGV0})
		_find_package(${ARGV})
	else()
		if(TARGET ${ARGV0}::${ARGV0})
			get_target_property(TGT_VER ${ARGV0}::${ARGV0} VERSION)
			set(TGT ${ARGV0}::${ARGV0})
		else()
			get_target_property(TGT_VER ${ARGV0} VERSION)
			set(TGT ${ARGV0})
		endif()
		message(STATUS "Found ${ARGV0}: CMake Target ${TGT} (found version \"${TGT_VER}\")")
		set(${ARGV0}_FOUND TRUE)
	endif()
endmacro()

if(POLICY CMP0068)
	# Don't modify install_name when touching RPATH.
	cmake_policy(SET CMP0068 NEW)
endif()

project(meta VERSION 1.0 LANGUAGES NONE)

include(CTest)
include(GNUInstallDirs)
set(CMAKE_VERBOSE_MAKEFILE ON)

if(UNIX)
  set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
  option(BUILD_SHARED_LIBS "Build shared libraries(.so)." ON)
else()
	# only support for static build on Windows.
 set(BUILD_SHARED_LIBS OFF)
endif()

# Build Dependencies
add_subdirectory(cmake)

add_subdirectory(Foo)
add_subdirectory(FooApp)

# Install
install(EXPORT CMakeCbcTargets
	NAMESPACE CMakeCbc::
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/CMakeCbc
	COMPONENT Devel)
include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/CMakeCbcConfig.cmake.in
	"${PROJECT_BINARY_DIR}/CMakeCbcConfig.cmake"
	INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/CMakeCbc"
	NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO)
write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/CMakeCbcConfigVersion.cmake"
	COMPATIBILITY SameMajorVersion)
install(
	FILES
	"${PROJECT_BINARY_DIR}/CMakeCbcConfig.cmake"
	"${PROJECT_BINARY_DIR}/CMakeCbcConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/CMakeCbc"
	COMPONENT Devel)
