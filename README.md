[![Build Status](https://travis-ci.org/Mizux/cmake-cbc.svg?branch=master)](https://travis-ci.org/Mizux/cmake-cbc)
[![Build status](https://ci.appveyor.com/api/projects/status/towef6objrs85mv0/branch/master?svg=true)](https://ci.appveyor.com/project/Mizux/cmake-cbc/branch/master)

# Introduction
This is an integration test of Cbc in a Modern [CMake](https://cmake.org/) C++ Project using
 [ExternalProject](https://cmake.org/cmake/help/latest/module/ExternalProject.html) module.

This project should run on Linux, Mac and Windows.

# CMake Dependencies Tree
This CMake project is composed of one executable (FooApp)
with the following dependencies:  
```
ZLIB:
Cbc: ZLIB
FooApp: Cbc
```
All dependencies are built in static to have one standalone executable.

## Project directory layout
Thus the project layout is as follow:
```
 CMakeLists.txt // meta CMake doing the orchestration.
 cmake
 ├── CMakeLists.txt
 ├── zlib.CMakeLists.txt
 ├── cbc.CMakeLists.txt
 patches
 ├── zlib.patch
 ├── cbc.patch
 FooApp
 ├── CMakeLists.txt
 └── src
     └── main.cpp
```

# C++ Project Build
To build the C++ project, as usual:
```sh
cmake -H. -Bbuild -DCMAKE_VERBOSE_MAKEFILE=ON
cmake --build build
```

# Contributing
The [CONTRIBUTING.md](./CONTRIBUTING.md) file contains instructions on how to
file the Contributor License Agreement before sending any pull requests (PRs).
Of course, if you're new to the project, it's usually best to discuss any
proposals and reach consensus before sending your first PR.

# License
Apache 2. See the LICENSE file for details.

# Disclaimer
This is not an official Google product, it is just code that happens to be
owned by Google.
