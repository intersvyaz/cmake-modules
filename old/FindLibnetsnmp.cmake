# - Find libnetsnmp
# Find the native libnetsnmp includes and library.
# Once done this will define
#
#  LIBNETSNMP_INCLUDE_DIRS - where to find net-snmp/net-snmp-config.h, etc.
#  LIBNETSNMP_LIBRARIES    - List of libraries when using libnetsnp.
#  LIBNETSNMP_FOUND        - True if libnetsnmp found.

FIND_PATH(LIBNETSNMP_INCLUDE_DIR NAMES net-snmp/net-snmp-config.h)

FIND_LIBRARY(LIBNETSNMP_LIBRARY NAMES snmp netsnmp)

MARK_AS_ADVANCED(LIBNETSNMP_LIBRARY LIBNETSNMP_INCLUDE_DIR)

IF(LIBNETSNMP_INCLUDE_DIR)
    IF(EXISTS "${LIBNETSNMP_INCLUDE_DIR}/net-snmp/net-snmp-config-x86_64.h")
        FILE(READ "${LIBNETSNMP_INCLUDE_DIR}/net-snmp/net-snmp-config-x86_64.h" _libnetsnmp_HEADER_CONTENTS)
    ELSEIF(EXISTS "${LIBNETSNMP_INCLUDE_DIR}/net-snmp/net-snmp-config.h")
        FILE(READ "${LIBNETSNMP_INCLUDE_DIR}/net-snmp/net-snmp-config.h" _libnetsnmp_HEADER_CONTENTS)
    ENDIF()
ENDIF()

IF(_libnetsnmp_HEADER_CONTENTS)
    # Read and parse net-snmp version header file for version number
    STRING(REGEX MATCH "PACKAGE_VERSION +\"[0-9\\.]+\"" _libnetsnmp_HEADER_CONTENTS "${_libnetsnmp_HEADER_CONTENTS}")

    IF(_libnetsnmp_HEADER_CONTENTS EQUAL "")
        SET(LIBNETSNMP_VERSION_MAJOR 0)
        SET(LIBNETSNMP_VERSION_MINOR 0)
        SET(LIBNETSNMP_VERSION_UPDATE 0)
        SET(LIBNETSNMP_VERSION_BUILD 0)
    ELSE()
        STRING(REGEX REPLACE "PACKAGE_VERSION +\"([0-9]+).*" "\\1" LIBNETSNMP_VERSION_MAJOR "${_libnetsnmp_HEADER_CONTENTS}")
        STRING(REGEX REPLACE "PACKAGE_VERSION +\"[0-9]+\\.([0-9]+).*" "\\1" LIBNETSNMP_VERSION_MINOR "${_libnetsnmp_HEADER_CONTENTS}")
        IF(_libnetsnmp_HEADER_CONTENTS MATCHES "PACKAGE_VERSION +\"[0-9]+\\.[0-9]+\\.[0-9]+.*")
            STRING(REGEX REPLACE "PACKAGE_VERSION +\"[0-9]+\\.[0-9]+\\.([0-9]+).*" "\\1" LIBNETSNMP_VERSION_UPDATE "${_libnetsnmp_HEADER_CONTENTS}")
        ELSE()
            SET(LIBNETSNMP_VERSION_UPDATE 0)
        ENDIF()
        IF(_libnetsnmp_HEADER_CONTENTS MATCHES "PACKAGE_VERSION +\"[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+.*")
            STRING(REGEX REPLACE "PACKAGE_VERSION +\"[0-9]+\\.[0-9]+\\.[0-9]+\\.([0-9]+).*" "\\1" LIBNETSNMP_VERSION_BUILD "${_libnetsnmp_HEADER_CONTENTS}")
        ELSE()
            SET(LIBNETSNMP_VERSION_BUILD 0)
        ENDIF()
    ENDIF()

    SET(LIBNETSNMP_VERSION_STRING "${LIBNETSNMP_VERSION_MAJOR}.${LIBNETSNMP_VERSION_MINOR}.${LIBNETSNMP_VERSION_UPDATE}.${LIBNETSNMP_VERSION_BUILD}")
ENDIF()

# handle the QUIETLY and REQUIRED arguments and set LIBNETSNMP_FOUND to TRUE if
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Libnetsnmp
    REQUIRED_VARS LIBNETSNMP_LIBRARY LIBNETSNMP_INCLUDE_DIR
    VERSION_VAR LIBNETSNMP_VERSION_STRING
)

IF(LIBNETSNMP_FOUND)
    SET(LIBNETSNMP_INCLUDE_DIRS ${LIBNETSNMP_INCLUDE_DIR})
    SET(LIBNETSNMP_LIBRARIES ${LIBNETSNMP_LIBRARY})
ENDIF()
