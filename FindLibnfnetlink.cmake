# - Find libnfnetlink
# Find the native libnfnetlink includes and library.
# Once done this will define
#
#  LIBNFNETLINK_INCLUDE_DIRS - where to find libnfnetlink/libnfnetlink.h, etc.
#  LIBNFNETLINK_LIBRARIES    - List of libraries when using libnfnetlink.
#  LIBNFNETLINK_FOUND        - True if libnfnetlink found.

FIND_PATH(LIBNFNETLINK_INCLUDE_DIR NAMES libnfnetlink/libnfnetlink.h)
FIND_LIBRARY(LIBNFNETLINK_LIBRARY NAMES nfnetlink)

MARK_AS_ADVANCED(LIBNFNETLINK_LIBRARY LIBNFNETLINK_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set LIBNFNETLINK_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Libnfnetlink
    REQUIRED_VARS LIBNFNETLINK_LIBRARY LIBNFNETLINK_INCLUDE_DIR
)

IF(LIBNFNETLINK_FOUND)
    SET(LIBNFNETLINK_INCLUDE_DIRS ${LIBNFNETLINK_INCLUDE_DIR})
    SET(LIBNFNETLINK_LIBRARIES ${LIBNFNETLINK_LIBRARY})
ENDIF()