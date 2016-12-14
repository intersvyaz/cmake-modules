# - Try to find LibPcap
# Once done this will define
#  LIBPCAP_FOUND - System has LibPcap
#  LIBPCAP_INCLUDE_DIRS - The LibPcap include directories
#  LIBPCAP_LIBRARIES - The libraries needed to use LibPcap
#  LIBPCAP_DEFINITIONS - Compiler switches required for using LibPcap
#  LIBPCAP_VERSION - LibPcap version

find_package(PkgConfig)
pkg_check_modules(PC_LIBPCAP QUIET libpcap)
set(LIBPCAP_DEFINITIONS ${PC_LIBPCAP_CFLAGS_OTHER})

find_path(LIBPCAP_INCLUDE_DIR pcap.h
        HINTS ${PC_LIBPCAP_INCLUDEDIR} ${PC_LIBPCAP_INCLUDE_DIRS}
        )

find_library(LIBPCAP_LIBRARY NAMES pcap libpcap
        HINTS ${PC_LIBPCAP_LIBDIR} ${PC_LIBPCAP_LIBRARY_DIRS})

if (NOT PC_LIBPCAP_VERSION STREQUAL "")
    set(LIBPCAP_VERSION ${PC_LIBPCAP_VERSION})
else ()
    set(LIBPCAP_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibPCAP
        REQUIRED_VARS LIBPCAP_LIBRARY LIBPCAP_INCLUDE_DIR
        VERSION_VAR LIBPCAP_VERSION
        )

MARK_AS_ADVANCED(LIBPCAP_LIBRARY LIBPCAP_INCLUDE_DIR)

set(LIBPCAP_LIBRARIES ${LIBPCAP_LIBRARY})
set(LIBPCAP_INCLUDE_DIRS ${LIBPCAP_INCLUDE_DIR})
