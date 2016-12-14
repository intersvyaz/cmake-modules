# - Try to find LibCheck
# Once done this will define
#  LIBCHECK_FOUND - System has LibCheck
#  LIBCHECK_INCLUDE_DIRS - The LibCheck include directories
#  LIBCHECK_LIBRARIES - The libraries needed to use LibCheck
#  LIBCHECK_DEFINITIONS - Compiler switches required for using LibCheck
#  LIBCHECK_VERSION - LibCheck version

find_package(PkgConfig)
pkg_check_modules(PC_LIBCHECK QUIET check)
set(LIBCHECK_DEFINITIONS ${PC_LIBCHECK_CFLAGS_OTHER})

find_path(LIBCHECK_INCLUDE_DIR check.h
        HINTS ${PC_LIBCHECK_INCLUDEDIR} ${PC_LIBCHECK_INCLUDE_DIRS}
        )

find_library(LIBCHECK_LIBRARY NAMES check libcheck
        HINTS ${PC_LIBCHECK_LIBDIR} ${PC_LIBCHECK_LIBRARY_DIRS})

if (NOT PC_LIBCHECK_VERSION STREQUAL "")
    set(LIBCHECK_VERSION ${PC_LIBCHECK_VERSION})
elseif (EXISTS ${LIBCHECK_INCLUDE_DIR}/check.h)
    # Read and parse version header file for version number
    file(READ ${LIBCHECK_INCLUDE_DIR}/check.h _LIBCHECK_HEADER_CONTENTS)
    if (_LIBCHECK_HEADER_CONTENTS MATCHES ".*CHECK_MAJOR_VERSION.*")
        string(REGEX REPLACE ".*#define CHECK_MAJOR_VERSION +([0-9]+).*" "\\1" LIBCHECK_VERSION_MAJOR "${_LIBCHECK_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define CHECK_MINOR_VERSION +([0-9]+).*" "\\1" LIBCHECK_VERSION_MINOR "${_LIBCHECK_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define CHECK_MICRO_VERSION +([0-9]+).*" "\\1" LIBCHECK_VERSION_PATCH "${_LIBCHECK_HEADER_CONTENTS}")
        set(LIBCHECK_VERSION ${LIBCHECK_VERSION_MAJOR}.${LIBCHECK_VERSION_MINOR}.${LIBCHECK_VERSION_PATCH})
    else ()
        set(LIBCHECK_VERSION 0.0.0)
    endif ()
else ()
    set(LIBCHECK_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibCheck
        REQUIRED_VARS LIBCHECK_LIBRARY LIBCHECK_INCLUDE_DIR
        VERSION_VAR LIBCHECK_VERSION
        )

MARK_AS_ADVANCED(LIBCHECK_LIBRARY LIBCHECK_INCLUDE_DIR)

set(LIBCHECK_LIBRARIES ${LIBCHECK_LIBRARY})
set(LIBCHECK_INCLUDE_DIRS ${LIBCHECK_INCLUDE_DIR})
