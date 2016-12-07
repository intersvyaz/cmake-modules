# - Find libzmq
# Find the native libzmq includes and library.
# Once done this will define
#
#  LIBZMQ_INCLUDE_DIRS - where to find zmq.h, etc.
#  LIBZMQ_LIBRARIES    - List of libraries when using libzmq.
#  LIBZMQ_FOUND        - True if libzmq found.
#
#  LIBZMQ_VERSION_STRING - The version of libzmq found (x.y.z)
#  LIBZMQ_VERSION_MAJOR  - The major version
#  LIBZMQ_VERSION_MINOR  - The minor version
#  LIBZMQ_VERSION_PATCH  - The patch version

FIND_PATH(LIBZMQ_INCLUDE_DIR NAMES zmq.h)
FIND_LIBRARY(LIBZMQ_LIBRARY  NAMES zmq)

MARK_AS_ADVANCED(LIBZMQ_LIBRARY LIBZMQ_INCLUDE_DIR)

IF(LIBZMQ_INCLUDE_DIR AND EXISTS "${LIBZMQ_INCLUDE_DIR}/zmq.h")
    # Read and parse version header file for version number
    file(READ "${LIBZMQ_INCLUDE_DIR}/zmq.h" _libzmq_HEADER_CONTENTS)
    IF(_libzmq_HEADER_CONTENTS MATCHES ".*ZMQ_VERSION_MAJOR.*")
        string(REGEX REPLACE ".*#define +ZMQ_VERSION_MAJOR +([0-9]+).*" "\\1" LIBZMQ_VERSION_MAJOR "${_libzmq_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +ZMQ_VERSION_MINOR +([0-9]+).*" "\\1" LIBZMQ_VERSION_MINOR "${_libzmq_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define +ZMQ_VERSION_PATCH +([0-9]+).*" "\\1" LIBZMQ_VERSION_PATCH "${_libzmq_HEADER_CONTENTS}")
    ELSE()
       SET(LIBZMQ_VERSION_MAJOR 0)
       SET(LIBZMQ_VERSION_MINOR 0)
       SET(LIBZMQ_VERSION_PATCH 0)
    ENDIF()

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
