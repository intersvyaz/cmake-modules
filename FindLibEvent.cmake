# - Try to find LibEvent
# Once done this will define
#
#  LIBEVENT_FOUND - System has LibEvent
#  LIBEVENT_INCLUDE_DIRS - The LibEvent include directories
#  LIBEVENT_LIBRARIES - The libraries needed to use LibEvent
#  LIBEVENT_DEFINITIONS - Compiler switches required for using LibEvent
#  LIBEVENT_VERSION - LibEvent version
#
#  LIBEVENT_<C>_FOUND - System has LibEvent component <C>
#  LIBEVENT_<C>_LIBRARIES - The libraries needed to use LibEvent component <C>
#  LIBEVENT_<C>_DEFINITIONS - Compiler switches required for using LibEvent component <C>
#
# Avaliable components:
#  event - all-in-one bundle
#  event_core
#  event_pthreads
#  event_extra
#  event_openssl
#

find_package(PkgConfig)
pkg_check_modules(PC_LIBEVENT QUIET libevent)

find_path(LIBEVENT_INCLUDE_DIR event2/event.h
        HINTS ${PC_LIBEVENT_INCLUDEDIR} ${PC_LIBEVENT_INCLUDE_DIRS}
        )

if (LibEvent_FIND_COMPONENTS)
    foreach (comp ${LibEvent_FIND_COMPONENTS})
        pkg_check_modules(PC_LIBEVENT_${comp} QUIET lib${comp})
        find_library(LIBEVENT_${comp}_LIBRARY NAMES ${comp}
                HINTS ${PC_LIBEVENT_${comp}_LIBDIR} ${PC_LIBEVENT_${comp}_LIBRARY_DIRS})
        set(LIBEVENT_${comp}_DEFINITIONS ${PC_LIBEVENT_${comp}_CFLAGS_OTHER})
        if (LIBEVENT_${comp}_LIBRARY)
            set(LibEvent_${comp}_FOUND 1)
            set(LIBEVENT_DEFINITIONS "${LIBEVENT_DEFINITIONS} ${LIBEVENT_${comp}_DEFINITIONS}")
            list(APPEND LIBEVENT_LIBRARY ${LIBEVENT_${comp}_LIBRARY})
            mark_as_advanced(LIBEVENT_${comp}_LIBRARY)
            set(LIBEVENT_${comp}_LIBRARIES LIBEVENT_${comp}_LIBRARY)
        endif ()
    endforeach ()
endif ()

if (NOT PC_LIBEVENT_VERSION STREQUAL "")
    set(LIBEVENT_VERSION ${PC_LIBEVENT_VERSION})
elseif (EXISTS ${LIBEVENT_INCLUDE_DIR}/event2/event-config.h)
    # Read and parse version header file for version number
    file(READ ${LIBEVENT_INCLUDE_DIR}/event2/event-config.h _LIBEVENT_HEADER_CONTENTS)
    if (_LIBEVENT_HEADER_CONTENTS MATCHES ".*_EVENT_VERSION.*")
        string(REGEX REPLACE ".*#define _EVENT_VERSION +\"([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1" LIBEVENT_VERSION ${_LIBEVENT_HEADER_CONTENTS})
    else ()
        set(LIBEVENT_VERSION 0.0.0)
    endif ()
else ()
    set(LIBEVENT_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibEvent
        REQUIRED_VARS LIBEVENT_LIBRARY LIBEVENT_INCLUDE_DIR
        VERSION_VAR LIBEVENT_VERSION
        HANDLE_COMPONENTS
        )

mark_as_advanced(LIBEVENT_LIBRARY LIBEVENT_INCLUDE_DIR)

set(LIBEVENT_LIBRARIES ${LIBEVENT_LIBRARY})
set(LIBEVENT_INCLUDE_DIRS ${LIBEVENT_INCLUDE_DIR})
