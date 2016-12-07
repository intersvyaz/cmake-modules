# - Try to find DPDK
# Once done this will define
#
#  DPDK_FOUND - System has DPDK
#  DPDK_INCLUDE_DIRS - The DPDK include directories
#  DPDK_LIBRARIES - The libraries needed to use DPDK
#  DPDK_DEFINITIONS - Compiler switches required for using DPDK
#  DPDK_VERSION - DPDK version
#
#  DPDK_<C>_FOUND - System has LibEvent component <C>
#  DPDK_<C>_LIBRARIES - The libraries needed to use LibEvent component <C>
#  DPDK_<C>_DEFINITIONS - Compiler switches required for using LibEvent component <C>
#
# Avaliable components:
#  dpdk - all-in-one bundle
#  rte_eal
#  TODO: add other separate components

find_package(PkgConfig)
pkg_check_modules(PC_DPDK QUIET dpdk)
set(DPDK_DEFINITIONS ${PC_DPDK_CFLAGS_OTHER})

find_path(DPDK_INCLUDE_DIR NAMES rte_config.h
        PATH_SUFFIXES dpdk
        HINTS ${PC_DPDK_INCLUDEDIR} ${PC_DPDK_INCLUDE_DIRS})

if (DPDK_FIND_COMPONENTS)
    foreach (comp ${DPDK_FIND_COMPONENTS})
        find_library(DPDK_${comp}_LIBRARY NAMES ${comp})
        if (DPDK_${comp}_LIBRARY)
            set(DPDK_${comp}_FOUND 1)
            list(APPEND DPDK_LIBRARY ${DPDK_${comp}_LIBRARY})
            mark_as_advanced(DPDK_${comp}_LIBRARY)
        endif ()
    endforeach ()
endif ()

if (NOT PC_DPDK_VERSION STREQUAL "")
    set(DPDK_VERSION ${PC_DPDK_VERSION})
elseif (EXISTS ${DPDK_INCLUDE_DIR}/rte_version.h)
    # Read and parse version header file for version number
    file(READ ${DPDK_INCLUDE_DIR}/rte_version.h _DPDK_HEADER_CONTENTS)
    if (_DPDK_HEADER_CONTENTS MATCHES ".*RTE_VER_YEAR.*")
        string(REGEX REPLACE ".*#define +RTE_VER_YEAR +([0-9]+).*" "\\1" DPDK_VERSION_YEAR "${_DPDK_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +RTE_VER_MONTH +([0-9]+).*" "\\1" DPDK_VERSION_MONTH "${_DPDK_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +RTE_VER_MINOR +([0-9]+).*" "\\1" DPDK_VERSION_MINOR "${_DPDK_HEADER_CONTENTS}")
        set(DPDK_VERSION ${DPDK_VERSION_YEAR}.${DPDK_VERSION_MONTH}.${DPDK_VERSION_MINOR})
    else ()
        set(LIBEVENT_VERSION 0.0.0)
    endif ()
else ()
    set(LIBEVENT_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DPDK
        REQUIRED_VARS DPDK_LIBRARY DPDK_INCLUDE_DIR
        VERSION_VAR DPDK_VERSION
        )

mark_as_advanced(DPDK_LIBRARY DPDK_INCLUDE_DIR)

set(DPDK_LIBRARIES ${DPDK_LIBRARY})
set(DPDK_INCLUDE_DIRS ${DPDK_INCLUDE_DIR})
