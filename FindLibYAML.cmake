# - Try to find LibYAML
# Once done this will define
#  LIBYAML_FOUND - System has LibYAML
#  LIBYAML_INCLUDE_DIRS - The LibYAML include directories
#  LIBYAML_LIBRARIES - The libraries needed to use LibYAML
#  LIBYAML_DEFINITIONS - Compiler switches required for using LibYAML
#  LIBYAML_VERSION - LibYAML version
#

find_package(PkgConfig)
pkg_check_modules(PC_LIBYAML QUIET yaml-0.1)
set(LIBYAML_DEFINITIONS ${PC_LIBYAML_CFLAGS_OTHER})

find_path(LIBYAML_INCLUDE_DIR yaml.h
        HINTS ${PC_LIBYAML_INCLUDEDIR} ${PC_LIBYAML_INCLUDE_DIRS}
        )

find_library(LIBYAML_LIBRARY NAMES yaml libyaml
        HINTS ${PC_LIBYAML_LIBDIR} ${PC_LIBYAML_LIBRARY_DIRS})

if (NOT PC_LIBYAML_VERSION STREQUAL "")
    set(LIBYAML_VERSION ${PC_LIBYAML_VERSION})
else ()
    set(LIBYAML_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibYAML
        REQUIRED_VARS LIBYAML_LIBRARY LIBYAML_INCLUDE_DIR
        VERSION_VAR LIBYAML_VERSION
        )

mark_as_advanced(LIBYAML_INCLUDE_DIR LIBYAML_LIBRARY)

set(LIBYAML_LIBRARIES ${LIBYAML_LIBRARY})
set(LIBYAML_INCLUDE_DIRS ${LIBYAML_INCLUDE_DIR})
