###############################################################################
#
# CMake module to search for Oracle client library (OCI)
#
# On success, the macro sets the following variables:
# ORACLE_FOUND       = if the library found
# ORACLE_LIBRARY     = full path to the library
# ORACLE_LIBRARIES   = full path to the library
# ORACLE_INCLUDE_DIR = where to find the library headers also defined,
#                       but not for general use are
#
# Copyright (c) 2015 Björn Berg, bjoern.berg@gmx.de
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
###############################################################################

# Depending on the system we can have set ORACLE_HOME and ORACLE_BASE.
# ORACLE_HOME is pointing to database or client directory
# ORACLE_BASE is the root installation directory for Oracle products

# If ORACLE_HOME not defined, test ORACLE_BASE otherwise skip
if(DEFINED ENV{ORACLE_HOME})
  set(ORACLE_DIR $ENV{ORACLE_HOME})
elseif(DEFINED ENV{ORACLE_BASE})
  if (EXISTS $ENV{ORACLE_BASE}/client_1)
    set(ORACLE_DIR $ENV{ORACLE_BASE}/client_1)
  else (EXISTS $ENV{ORACLE_BASE}/client_1)
    set(ORACLE_DIR $ENV{ORACLE_BASE}/db_1)
  endif(EXISTS $ENV{ORACLE_BASE}/client_1)
endif(DEFINED ENV{ORACLE_HOME})

if(DEFINED ORACLE_DIR)
  find_path(ORACLE_INCLUDE_DIR
    NAMES oci.h
    PATHS
    ${ORACLE_DIR}/rdbms/public
    ${ORACLE_DIR}/include
    ${ORACLE_DIR}/sdk/include  # Oracle SDK
    ${ORACLE_DIR}/OCI/include) # Oracle XE on Windows

  set(ORACLE_OCI_NAMES clntsh libclntsh oci)
  set(ORACLE_NNZ_NAMES nnz10 libnnz10 nnz11 libnnz11 ociw32)
  set(ORACLE_OCCI_NAMES libocci occi oraocci10 oraocci11)

  set(ORACLE_LIB_DIR 
    ${ORACLE_DIR}/lib
    ${ORACLE_DIR}/sdk/lib       # Oracle SDK
    ${ORACLE_DIR}/sdk/lib/msvc
    ${ORACLE_DIR}/OCI/lib/msvc) # Oracle XE on Windows

  find_library(ORACLE_OCI_LIBRARY  NAMES ${ORACLE_OCI_NAMES} PATHS ${ORACLE_LIB_DIR})
  find_library(ORACLE_OCCI_LIBRARY NAMES ${ORACLE_OCCI_NAMES} PATHS ${ORACLE_LIB_DIR})
  find_library(ORACLE_NNZ_LIBRARY NAMES ${ORACLE_NNZ_NAMES} PATHS ${ORACLE_LIB_DIR})

  set(ORACLE_LIBRARY ${ORACLE_OCI_LIBRARY} ${ORACLE_OCCI_LIBRARY} ${ORACLE_NNZ_LIBRARY})

  if(APPLE)
    set(ORACLE_OCIEI_NAMES libociei ociei)

    find_library(ORACLE_OCIEI_LIBRARY
      NAMES libociei ociei
      PATHS ${ORACLE_LIB_DIR})

    if(ORACLE_OCIEI_LIBRARY)
      set(ORACLE_LIBRARY ${ORACLE_LIBRARY} ${ORACLE_OCIEI_LIBRARY})
    else(ORACLE_OCIEI_LIBRARY)
      message(STATUS
        "libociei.dylib is not found. It may cause crash if you are building BUNDLE")
    endif()
  endif()

  set(ORACLE_LIBRARIES ${ORACLE_LIBRARY})
endif(DEFINED ORACLE_DIR)


# Handle the QUIETLY and REQUIRED arguments and set ORACLE_FOUND to TRUE
# if all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ORACLE DEFAULT_MSG ORACLE_LIBRARY ORACLE_INCLUDE_DIR)

mark_as_advanced(ORACLE_INCLUDE_DIR ORACLE_LIBRARY)