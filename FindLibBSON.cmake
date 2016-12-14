# - Try to find LibBSON
# Once done this will define
#  LIBBSON_FOUND - System has LibBSON
#  LIBBSON_INCLUDE_DIRS - The LibBSON include directories
#  LIBBSON_LIBRARIES - The libraries needed to use LibBSON
#  LIBBSON_DEFINITIONS - Compiler switches required for using LibBSON
#  LIBBSON_VERSION - LibBSON version

find_package(PkgConfig)
pkg_check_modules(PC_LIBBSON QUIET libbson-1.0)
set(LIBBSON_DEFINITIONS ${PC_LIBBSON_CFLAGS_OTHER})

find_path(LIBBSON_INCLUDE_DIR bson.h PATH_SUFFIXES libbson-1.0
        HINTS ${PC_LIBBSON_INCLUDEDIR} ${PC_LIBBSON_INCLUDE_DIRS}
        )

find_library(LIBBSON_LIBRARY NAMES bson-1.0 libbson-1.0
        HINTS ${PC_LIBBSON_LIBDIR} ${PC_LIBBSON_LIBRARY_DIRS})

if (NOT PC_LIBBSON_VERSION STREQUAL "")
    set(LIBBSON_VERSION ${PC_LIBBSON_VERSION})
elseif (EXISTS ${LIBBSON_INCLUDE_DIR}/bson-version.h)
    # Read and parse version header file for version number
    file(READ ${LIBBSON_INCLUDE_DIR}/bson-version.h _LIBBSON_HEADER_CONTENTS)
    if(_LIBBSON_HEADER_CONTENTS MATCHES ".*BSON_MAJOR_VERSION.*")
        string(REGEX REPLACE ".*#define +BSON_MAJOR_VERSION +\\(([0-9]+)\\).*" "\\1" LIBBSON_VERSION_MAJOR "${_LIBBSON_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +BSON_MINOR_VERSION +\\(([0-9]+)\\).*" "\\1" LIBBSON_VERSION_MINOR "${_LIBBSON_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +BSON_MICRO_VERSION +\\(([0-9]+)\\).*" "\\1" LIBBSON_VERSION_PATCH "${_LIBBSON_HEADER_CONTENTS}")
        set(LIBBSON_VERSION ${LIBBSON_VERSION_MAJOR}.${LIBBSON_VERSION_MINOR}.${LIBBSON_VERSION_PATCH})
    else ()
        set(LIBBSON_VERSION 0.0.0)
    endif ()
else ()
    set(LIBBSON_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibBSON
        REQUIRED_VARS LIBBSON_LIBRARY LIBBSON_INCLUDE_DIR
        VERSION_VAR LIBBSON_VERSION
        )

MARK_AS_ADVANCED(LIBBSON_LIBRARY LIBBSON_INCLUDE_DIR)

set(LIBBSON_LIBRARIES ${LIBBSON_LIBRARY})
set(LIBBSON_INCLUDE_DIRS ${LIBBSON_INCLUDE_DIR})
