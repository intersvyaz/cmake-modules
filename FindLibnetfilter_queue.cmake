# - Find libnetfilter_queue
# Find the native libnetfilter_queue includes and library.
# Once done this will define
#
#  LIBNETFILTER_QUEUE_INCLUDE_DIRS - where to find libnetfilter_queue/libnetfilter_queue.h, etc.
#  LIBNETFILTER_QUEUE_LIBRARIES    - List of libraries when using libnetfilter_queue.
#  LIBNETFILTER_QUEUE_FOUND        - True if libnetfilter_queue found.

FIND_PATH(LIBNETFILTER_QUEUE_INCLUDE_DIR NAMES libnetfilter_queue/libnetfilter_queue.h)
FIND_LIBRARY(LIBNETFILTER_QUEUE_LIBRARY NAMES netfilter_queue)

MARK_AS_ADVANCED(LIBNETFILTER_QUEUE_LIBRARY LIBNETFILTER_QUEUE_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set LIBNETFILTER_QUEUE_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Libnetfilter_queue
    REQUIRED_VARS LIBNETFILTER_QUEUE_LIBRARY LIBNETFILTER_QUEUE_INCLUDE_DIR
)

IF(LIBNETFILTER_QUEUE_FOUND)
    SET(LIBNETFILTER_QUEUE_INCLUDE_DIRS ${LIBNETFILTER_QUEUE_INCLUDE_DIR})
    SET(LIBNETFILTER_QUEUE_LIBRARIES ${LIBNETFILTER_QUEUE_LIBRARY})
ENDIF()