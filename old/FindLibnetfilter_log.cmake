# - Find libnetfilter_log
# Find the native libnetfilter_log includes and library.
# Once done this will define
#
#  LIBNETFILTER_LOG_INCLUDE_DIRS - where to find libnetfilter_log/libnetfilter_log.h, etc.
#  LIBNETFILTER_LOG_LIBRARIES    - List of libraries when using libnetfilter_log.
#  LIBNETFILTER_LOG_FOUND        - True if libnetfilter_log found.

FIND_PATH(LIBNETFILTER_LOG_INCLUDE_DIR NAMES libnetfilter_log/libnetfilter_log.h)
FIND_LIBRARY(LIBNETFILTER_LOG_LIBRARY NAMES netfilter_log)

MARK_AS_ADVANCED(LIBNETFILTER_LOG_LIBRARY LIBNETFILTER_LOG_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set LIBNETFILTER_LOG_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Libnetfilter_log
    REQUIRED_VARS LIBNETFILTER_LOG_LIBRARY LIBNETFILTER_LOG_INCLUDE_DIR
)

IF(LIBNETFILTER_LOG_FOUND)
    SET(LIBNETFILTER_LOG_INCLUDE_DIRS ${LIBNETFILTER_LOG_INCLUDE_DIR})
    SET(LIBNETFILTER_LOG_LIBRARIES ${LIBNETFILTER_LOG_LIBRARY})
ENDIF()