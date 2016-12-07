# - Try to find LibJSON-C
# Once done this will define
#  LIBJSON_C_FOUND - System has LibJSON-C
#  LIBJSON_C_INCLUDE_DIRS - The LibJSON-C include directories
#  LIBJSON_C_LIBRARIES - The libraries needed to use LibJSON-C
#  LIBJSON_C_DEFINITIONS - Compiler switches required for using LibJSON-C
#  LIBJSON_C_VERSION - LibJSON-C version

find_package(PkgConfig)
pkg_check_modules(PC_LIBJSON_C QUIET json-c)
set(LIBJSON_C_DEFINITIONS ${PC_LIBJSON_C_CFLAGS_OTHER})

find_path(LIBJSON_C_INCLUDE_DIR json-c/json.h
        HINTS ${PC_LIBJSON_C_INCLUDEDIR} ${PC_LIBJSON_C_INCLUDE_DIRS}
        )

find_library(LIBJSON_C_LIBRARY NAMES json-c libjson-c
        HINTS ${PC_LIBJSON_C_LIBDIR} ${PC_LIBJSON_C_LIBRARY_DIRS})

if (NOT PC_LIBJSON_C_VERSION STREQUAL "")
    set(LIBJSON_C_VERSION ${PC_LIBJSON_C_VERSION})
elseif (EXISTS ${LIBJSON_C_INCLUDE_DIR}/json-c/json-c-version.h)
    # Read and parse version header file for version number
    file(READ "${LIBJSON_C_INCLUDE_DIR}/json-c/json-c-version.h" _LIBJSON_C_HEADER_CONTENTS)
    if (_LIBJSON_C_HEADER_CONTENTS MATCHES ".*JSON_C_MAJOR_VERSION.*")
        string(REGEX REPLACE ".*#define +JSON_C_MAJOR_VERSION +\\(([0-9]+)\\).*" "\\1" _LIBJSON_C_VERSION_MAJOR ${_libjson-c_HEADER_CONTENTS})
        string(REGEX REPLACE ".*#define +JSON_C_MINOR_VERSION +\\(([0-9]+)\\).*" "\\1" _LIBJSON_C_VERSION_MINOR ${_libjson-c_HEADER_CONTENTS})
        string(REGEX REPLACE ".*#define +JSON_C_MICRO_VERSION +\\(([0-9]+)\\).*" "\\1" _LIBJSON_C_VERSION_PATCH ${_libjson-c_HEADER_CONTENTS})
        set(LIBJSON_C_VERSION ${_LIBJSON_C_VERSION_MAJOR}.${_LIBJSON_C_VERSION_MINOR}.${_LIBJSON_C_VERSION_PATCH})
    else ()
        set(LIBJSON_C_VERSION 0.0.0)
    endif ()
else ()
    set(LIBJSON_C_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibJSON-C
        REQUIRED_VARS LIBJSON_C_LIBRARY LIBJSON_C_INCLUDE_DIR
        VERSION_VAR LIBJSON_C_VERSION
        )

mark_as_advanced(LIBJSON_C_LIBRARY LIBJSON_C_INCLUDE_DIR)

set(LIBJSON_C_LIBRARIES ${LIBJSON_C_LIBRARY})
set(LIBJSON_C_INCLUDE_DIRS ${LIBJSON_C_INCLUDE_DIR})

