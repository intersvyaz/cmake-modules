# - Try to find LibConfig
# Once done this will define
#  LIBCONFIG_FOUND - System has LibConfig
#  LIBCONFIG_INCLUDE_DIRS - The LibConfig include directories
#  LIBCONFIG_LIBRARIES - The libraries needed to use LibConfig
#  LIBCONFIG_DEFINITIONS - Compiler switches required for using LibConfig
#  LIBCONFIG_VERSION - LibConfig version

find_package(PkgConfig)
pkg_check_modules(PC_LIBCONFIG QUIET libconfig)
set(LIBCONFIG_DEFINITIONS ${PC_LIBCONFIG_CFLAGS_OTHER})

find_path(LIBCONFIG_INCLUDE_DIR libconfig.h
        HINTS ${PC_LIBCONFIG_INCLUDEDIR} ${PC_LIBCONFIG_INCLUDE_DIRS}
        )

find_library(LIBCONFIG_LIBRARY NAMES config libconfig
        HINTS ${PC_LIBCONFIG_LIBDIR} ${PC_LIBCONFIG_LIBRARY_DIRS})

if (NOT PC_LIBCONFIG_VERSION STREQUAL "")
    set(LIBCONFIG_VERSION ${PC_LIBCONFIG_VERSION})
elseif (EXISTS ${LIBCONFIG_INCLUDE_DIR}/libconfig.h)
    # Read and parse version header file for version number
    file(READ ${LIBCONFIG_INCLUDE_DIR}/libconfig.h _LIBCONFIG_HEADER_CONTENTS)
    if(_LIBCONFIG_HEADER_CONTENTS MATCHES ".*LIBCONFIG_VER_MAJOR.*")
        string(REGEX REPLACE ".*#define LIBCONFIG_VER_MAJOR +([0-9]+).*" "\\1" LIBCONFIG_VERSION_MAJOR "${_LIBCONFIG_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define LIBCONFIG_VER_MINOR +([0-9]+).*" "\\1" LIBCONFIG_VERSION_MINOR "${_LIBCONFIG_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define LIBCONFIG_VER_REVISION +([0-9]+).*" "\\1" LIBCONFIG_VERSION_PATCH "${_LIBCONFIG_HEADER_CONTENTS}")
        set(LIBCONFIG_VERSION ${LIBCONFIG_VERSION_MAJOR}.${LIBCONFIG_VERSION_MINOR}.${LIBCONFIG_VERSION_PATCH})
    else ()
        set(LIBCONFIG_VERSION 0.0.0)
    endif ()
else ()
    set(LIBCONFIG_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibConfig
        REQUIRED_VARS LIBCONFIG_LIBRARY LIBCONFIG_INCLUDE_DIR
        VERSION_VAR LIBCONFIG_VERSION
        )

MARK_AS_ADVANCED(LIBCONFIG_LIBRARY LIBCONFIG_INCLUDE_DIR)

set(LIBCONFIG_LIBRARIES ${LIBCONFIG_LIBRARY})
set(LIBCONFIG_INCLUDE_DIRS ${LIBCONFIG_INCLUDE_DIR})
