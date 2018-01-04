set(BUILD_SHARED_LIBS OFF)
set(BUILD_TESTING OFF)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Backup the value of CMAKE_SKIP_INSTALL_RULES
set(_SKIP_INSTALL ${CMAKE_SKIP_INSTALL_RULES})
# TODO Keep install rules of dependencies (and adapt them if needed)
set(CMAKE_SKIP_INSTALL_RULES TRUE)

###############
##  COIN-OR  ##
###############
set(Cbc_VERSION "2.9.9")
set(CoinUtils_VERSION "2.10.14")
set(Osi_VERSION "0.107.9")
set(Clp_VERSION "1.16.11")
set(Cgl_VERSION "0.59.10")

include(Cbc)

set(CMAKE_SKIP_INSTALL_RULES ${_SKIP_INSTALL})
