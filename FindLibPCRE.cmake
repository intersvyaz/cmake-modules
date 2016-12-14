# - Try to find LibPCRE
# Once done this will define
#  LIBPCRE_FOUND - System has LibPCRE
#  LIBPCRE_INCLUDE_DIRS - The LibPCRE include directories
#  LIBPCRE_LIBRARIES - The libraries needed to use LibPCRE
#  LIBPCRE_DEFINITIONS - Compiler switches required for using LibPCRE
#  LIBPCRE_VERSION - LibPCRE version

find_package(PkgConfig)
pkg_check_modules(PC_LIBPCRE QUIET libpcre)
set(LIBPCRE_DEFINITIONS ${PC_LIBPCRE_CFLAGS_OTHER})

find_path(LIBPCRE_INCLUDE_DIR pcre.h
        HINTS ${PC_LIBPCRE_INCLUDEDIR} ${PC_LIBPCRE_INCLUDE_DIRS}
        )

find_library(LIBPCRE_LIBRARY NAMES pcre libpcre
        HINTS ${PC_LIBPCRE_LIBDIR} ${PC_LIBPCRE_LIBRARY_DIRS})

if (NOT PC_LIBPCRE_VERSION STREQUAL "")
    set(LIBPCRE_VERSION ${PC_LIBPCRE_VERSION})
elseif (EXISTS ${LIBPCRE_INCLUDE_DIR}/pcre.h)
    # Read and parse version header file for version number
    file(READ ${LIBPCRE_INCLUDE_DIR}/pcre.h _LIBPCRE_HEADER_CONTENTS)
    if(_LIBPCRE_HEADER_CONTENTS MATCHES ".*PCRE_MAJOR.*")
        string(REGEX REPLACE ".*#define +PCRE_MAJOR +([0-9]+).*" "\\1" LIBPCRE_VERSION_MAJOR "${_LIBPCRE_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +PCRE_MINOR +([0-9]+).*" "\\1" LIBPCRE_VERSION_MINOR "${_LIBPCRE_HEADER_CONTENTS}")
        set(LIBPCRE_VERSION ${LIBPCRE_VERSION_MAJOR}.${LIBPCRE_VERSION_MINOR}.0)
    else ()
        set(LIBPCRE_VERSION 0.0.0)
    endif ()
else ()
    set(LIBPCRE_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibPCRE
        REQUIRED_VARS LIBPCRE_LIBRARY LIBPCRE_INCLUDE_DIR
        VERSION_VAR LIBPCRE_VERSION
        )

MARK_AS_ADVANCED(LIBPCRE_LIBRARY LIBPCRE_INCLUDE_DIR)

set(LIBPCRE_LIBRARIES ${LIBPCRE_LIBRARY})
set(LIBPCRE_INCLUDE_DIRS ${LIBPCRE_INCLUDE_DIR})
