# - Find libzmq
# Find the native libzmq includes and library.
# Once done this will define
#
#  LIBZMQ_INCLUDE_DIRS - where to find net-snmp/net-snmp-config.h, etc.
#  LIBZMQ_LIBRARIES    - List of libraries when using libnetsnp.
#  LIBZMQ_FOUND        - True if libzmq found.

FIND_PATH(LIBZMQ_INCLUDE_DIR NAMES zmq.h)

FIND_LIBRARY(LIBZMQ_LIBRARY NAMES zmq)

MARK_AS_ADVANCED(LIBZMQ_LIBRARY LIBZMQ_INCLUDE_DIR)

IF(LIBZMQ_INCLUDE_DIR AND EXISTS "${LIBZMQ_INCLUDE_DIR}/zmq.h")
    # Read and parse zmq version header file for version number
    file(READ "${LIBZMQ_INCLUDE_DIR}/zmq.h" _zmq_HEADER_CONTENTS)

    string(REGEX REPLACE ".*#define ZMQ_VERSION_MAJOR +([0-9]+).*" "\\1" LIBZMQ_VERSION_MAJOR "${_zmq_HEADER_CONTENTS}")
    string(REGEX REPLACE ".*#define ZMQ_VERSION_MINOR +([0-9]+).*" "\\1" LIBZMQ_VERSION_MINOR "${_zmq_HEADER_CONTENTS}")
    string(REGEX REPLACE ".*#define ZMQ_VERSION_PATCH +([\\.0-9]*).*" "\\1" LIBZMQ_VERSION_PATCH "${_zmq_HEADER_CONTENTS}")

    SET(LIBZMQ_VERSION_STRING "${LIBZMQ_VERSION_MAJOR}.${LIBZMQ_VERSION_MINOR}.${LIBZMQ_VERSION_PATCH}")
ENDIF()


# handle the QUIETLY and REQUIRED arguments and set LIBZMQ_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Libzmq
    REQUIRED_VARS LIBZMQ_LIBRARY LIBZMQ_INCLUDE_DIR
    VERSION_VAR LIBZMQ_VERSION_STRING
)

IF(LIBZMQ_FOUND)
    SET(LIBZMQ_INCLUDE_DIRS ${LIBZMQ_INCLUDE_DIR})
    SET(LIBZMQ_LIBRARIES ${LIBZMQ_LIBRARY})
ENDIF()
