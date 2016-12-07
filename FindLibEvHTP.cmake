# - Try to find LibEvHTP
# Once done this will define
#  LIBEVHTP_FOUND - System has LibEvHTP
#  LIBEVHTP_INCLUDE_DIRS - The LibEvHTP include directories
#  LIBEVHTP_LIBRARIES - The libraries needed to use LibEvHTP
#  LIBEVHTP_DEFINITIONS - Compiler switches required for using LibEvHTP
#  LIBEVHTP_VERSION - LibEvHTP version

find_package(PkgConfig)
pkg_check_modules(PC_LIBEVHTP QUIET evhtp)
set(LIBEVHTP_DEFINITIONS ${PC_LIBEVHTP_CFLAGS_OTHER})

find_path(LIBEVHTP_INCLUDE_DIR evhtp.h PATH_SUFFIXES evhtp
        HINTS ${PC_LIBEVHTP_INCLUDEDIR} ${PC_LIBEVHTP_INCLUDE_DIRS}
        )

find_library(LIBEVHTP_LIBRARY NAMES evhtp libevhtp
        HINTS ${PC_LIBEVHTP_LIBDIR} ${PC_LIBEVHTP_LIBRARY_DIRS})

if (NOT PC_LIBEVHTP_VERSION STREQUAL "")
    set(LIBEVHTP_VERSION ${PC_LIBEVHTP_VERSION})
elseif (EXISTS ${LIBEVHTP_INCLUDE_DIR}/evhtp.h)
    # Read and parse version header file for version number
    file(READ ${LIBEVHTP_INCLUDE_DIR}/evhtp.h _LIBEVHTP_HEADER_CONTENTS)
    if (_LIBEVHTP_HEADER_CONTENTS MATCHES ".*EVHTP_VERSION.*")
        string(REGEX REPLACE ".*#define EVHTP_VERSION +\"([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1" LIBEVHTP_VERSION "${_LIBEVHTP_HEADER_CONTENTS}")
    else ()
        set(LIBEVHTP_VERSION 0.0.0)
    endif ()
else ()
    set(LIBEVHTP_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibEvHTP
        REQUIRED_VARS LIBEVHTP_LIBRARY LIBEVHTP_INCLUDE_DIR
        VERSION_VAR LIBEVHTP_VERSION
        )

MARK_AS_ADVANCED(LIBEVHTP_LIBRARY LIBEVHTP_INCLUDE_DIR)

set(LIBEVHTP_LIBRARIES ${LIBEVHTP_LIBRARY})
set(LIBEVHTP_INCLUDE_DIRS ${LIBEVHTP_INCLUDE_DIR})
