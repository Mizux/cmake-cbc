set_property(DIRECTORY PROPERTY EP_BASE ../coin)

include(ExternalProject)
ExternalProject_Add(${COIN_PROJECT}_project
	GIT_REPOSITORY ${${COIN_PROJECT}_URL}
	GIT_TAG "releases/${${COIN_PROJECT}_VERSION}"
	INSTALL_DIR ../coin/Install
	BUILD_IN_SOURCE 1
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND <SOURCE_DIR>/configure
	--enable-silent-rules --disable-bzlib --without-lapack --with-pic
	--enable-static --prefix=<INSTALL_DIR>
	ADD_CXXFLAGS=${ADD_CXXFLAGS}
	TEST_COMMAND ""
	)
