# - Try to find LibGoogle-perftools
# Once done this will define
#
#  LIBGOOGLE_PERFTOOLS_FOUND - System has LibGoogle-perftools
#  LIBGOOGLE_PERFTOOLS_INCLUDE_DIRS - The LibGoogle-perftools include directories
#  LIBGOOGLE_PERFTOOLS_VERSION - LibGoogle-perftools version
#
#  LIBGOOGLE_PERFTOOLS_<C>_FOUND - System has LibGoogle-perftools component <C>
#  LIBGOOGLE_PERFTOOLS_<C>_LIBRARIES - The libraries needed to use LibGoogle-perftools component <C>
#
# Avaliable components:
#  profiler
#  tcmalloc
#  tcmalloc_and_profiler
#  tcmalloc_debug
#  tcmalloc_minimal
#  tcmalloc_minimal_debug

find_path(LIBGOOGLE_PERFTOOLS_INCLUDE_DIR gperftools/tcmalloc.h)

if (LibGoogle-perftools_FIND_COMPONENTS)
    foreach (comp ${LibGoogle-perftools_FIND_COMPONENTS})
        find_library(LIBGOOGLE_PERFTOOLS_${comp}_LIBRARY NAMES ${comp} lib${comp})
        if (LIBGOOGLE_PERFTOOLS_${comp}_LIBRARY)
            set(LibGoogle-perftools_${comp}_FOUND 1)
            mark_as_advanced(LIBGOOGLE_PERFTOOLS_${comp}_LIBRARY)
            set(LIBGOOGLE_PERFTOOLS_${comp}_LIBRARIES ${LIBGOOGLE_PERFTOOLS_${comp}_LIBRARY})
        endif ()
    endforeach ()
endif ()

if (EXISTS ${LIBGOOGLE_PERFTOOLS_INCLUDE_DIR}/gperftools/tcmalloc.h)
    # Read and parse version header file for version number
    file(READ ${LIBGOOGLE_PERFTOOLS_INCLUDE_DIR}/gperftools/tcmalloc.h _LIBGOOGLE_PERFTOOLS_HEADER_CONTENTS)
    if (_LIBGOOGLE_PERFTOOLS_HEADER_CONTENTS MATCHES ".*TC_VERSION_MAJOR.*")
        string(REGEX REPLACE ".*#define TC_VERSION_MAJOR +([0-9]+).*" "\\1" LIBGOOGLE_PERFTOOLS_VERSION_MAJOR "${_LIBGOOGLE_PERFTOOLS_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define TC_VERSION_MINOR +([0-9]+).*" "\\1" LIBGOOGLE_PERFTOOLS_VERSION_MINOR "${_LIBGOOGLE_PERFTOOLS_HEADER_CONTENTS}")
        string(REGEX REPLACE ".*#define TC_VERSION_PATCH +\"\\.([0-9]*)\".*" "\\1" LIBGOOGLE_PERFTOOLS_VERSION_PATCH "${_LIBGOOGLE_PERFTOOLS_HEADER_CONTENTS}")
        set(LIBGOOGLE_PERFTOOLS_VERSION ${LIBGOOGLE_PERFTOOLS_VERSION_MAJOR}.${LIBGOOGLE_PERFTOOLS_VERSION_MINOR}.${LIBGOOGLE_PERFTOOLS_VERSION_PATCH})
    else ()
        set(LIBGOOGLE_PERFTOOLS_VERSION 0.0.0)
    endif ()
else ()
    set(LIBGOOGLE_PERFTOOLS_VERSION 0.0.0)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibGoogle-perftools
        REQUIRED_VARS LIBGOOGLE_PERFTOOLS_INCLUDE_DIR
        VERSION_VAR LIBGOOGLE_PERFTOOLS_VERSION
        HANDLE_COMPONENTS
        )

mark_as_advanced(LIBGOOGLE_PERFTOOLS_INCLUDE_DIR)

set(LIBGOOGLE_PERFTOOLS_INCLUDE_DIRS ${LIBGOOGLE_PERFTOOLS_INCLUDE_DIR})
