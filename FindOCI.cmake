# - Find OCI
# Find OCI includes and library.
# Once done this will define
#
#  OCI_INCLUDE_DIRS - where to find oci.h, etc.
#  OCI_LIBRARIES    - List of libraries when using OCI.
#  OCI_FOUND        - True if OCI found.

FIND_PATH(OCI_INCLUDE_DIR oci.h
  PATHS $ENV{ORACLE_HOME}/include
  PATH_SUFFIXES oci
)

FIND_LIBRARY(OCI_LIBRARY clntsh oci
  PATHS $ENV{ORACLE_HOME}/lib
)

MARK_AS_ADVANCED(OCI_LIBRARY OCI_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set OCI_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(OCI
    REQUIRED_VARS OCI_LIBRARY OCI_INCLUDE_DIR
)

IF(OCI_FOUND)
    SET(OCI_INCLUDE_DIRS ${OCI_INCLUDE_DIR})
    SET(OCI_LIBRARIES ${OCI_LIBRARY})
ENDIF()
