# - Try to find LibURCU
# Once done this will define
#
#  LIBURCU_FOUND - System has LibURCU
#  LIBURCU_INCLUDE_DIRS - The LibURCU include directories
#  LIBURCU_VERSION - LibURCU version
#
#  LIBURCU_<C>_FOUND - System has LibURCU component <C>
#  LIBURCU_<C>_LIBRARIES - The libraries needed to use LibURCU component <C>
#  LIBURCU_<C>_DEFINITIONS - Compiler switches required for using LibURCU component <C>
#
# Avaliable components:
#  urcu
#  urcu-qsbr
#  urcu-mb
#  urcu-signal
#  urcu-bp

find_package(PkgConfig)
pkg_check_modules(PC_LIBURCU QUIET liburcu)

find_path(LIBURCU_INCLUDE_DIR urcu.h
        HINTS ${PC_LIBURCU_INCLUDEDIR} ${PC_LIBURCU_INCLUDE_DIRS}
        )

if (LibURCU_FIND_COMPONENTS)
    foreach (comp ${LibURCU_FIND_COMPONENTS})
        pkg_check_modules(PC_LIBURCU_${comp} QUIET lib${comp})
        find_library(LIBURCU_${comp}_LIBRARY NAMES ${comp}
                HINTS ${PC_LIBURCU_${comp}_LIBDIR} ${PC_LIBURCU_${comp}_LIBRARY_DIRS})
        set(LIBURCU_${comp}_DEFINITIONS ${PC_LIBURCU_${comp}_CFLAGS_OTHER})
        if (LIBURCU_${comp}_LIBRARY)
            set(LibURCU_${comp}_FOUND 1)
            mark_as_advanced(LIBURCU_${comp}_LIBRARY)
            set(LIBURCU_${comp}_LIBRARIES ${LIBURCU_${comp}_LIBRARY})
        endif ()
    endforeach ()
endif ()

if (NOT PC_LIBURCU_VERSION STREQUAL "")
    set(LIBURCU_VERSION ${PC_LIBURCU_VERSION})
else ()
    set(LIBURCU_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibURCU
        REQUIRED_VARS LIBURCU_INCLUDE_DIR
        VERSION_VAR LIBURCU_VERSION
        HANDLE_COMPONENTS
        )

mark_as_advanced(LIBURCU_LIBRARY LIBURCU_INCLUDE_DIR)

set(LIBURCU_LIBRARIES ${LIBURCU_LIBRARY})
set(LIBURCU_INCLUDE_DIRS ${LIBURCU_INCLUDE_DIR})
