# 	Find iconv library
#
#	Author: Björn Berg, bjoern.berg@gmx.de
#	Redistribution and use is allowed according to the terms of the BSD license.
# 	For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
#	LOG4CPLUS_INCLUDE_DIRS	-	where to find iconv.h
#	LOG4CPLUS_LIBRARIES		-	Lists of libraries when using iconv
#	LOG4CPLUS_FOUND			-	True if iconv found
#

# We try to find Log4cplus first by its environment variable
# If this environment variable is set we use it as hint (mostly on Windows)
if (DEFINED ENV{LOG4CPLUS_ROOT})
	set(LOG4CPLUS_ROOT $ENV{LOG4CPLUS_ROOT})
endif()

# Search for the header file
set (LOG4CPLUS_HEADER_FILES log4cplus/appender.h log4cplus/logger.h log4cplus/clogger.h)
find_path( LOG4CPLUS_INCLUDE_DIR 
	NAMES ${LOG4CPLUS_HEADER_FILES} 
	HINTS 
	${LOG4CPLUS_ROOT}/include)

# Search for the libraries
set( LOG4CPLUS_LIB_NAMES log4cplusS log4cplusU liblog4cplusS liblog4cplusU )
find_library( LOG4CPLUS_LIBRARIES 
	NAMES ${LOG4CPLUS_LIB_NAMES}
	HINTS
	${LOG4CPLUS_ROOT}/src 
	${LOG4CPLUS_ROOT}/lib )

# Copy results to output variables
set( LOG4CPLUS_INCLUDE_DIRS ${LOG4CPLUS_INCLUDE_DIR} )

# Check if ICONV was found
if (LOG4CPLUS_INCLUDE_DIRS AND LOG4CPLUS_LIBRARIES)
	set( LOG4CPLUS_FOUND true)	
endif (LOG4CPLUS_INCLUDE_DIRS AND LOG4CPLUS_LIBRARIES)

# Print a helpful message if not found
if (NOT LOG4CPLUS_FOUND)
	message(FATAL_ERROR "Cannot find log4cplus. Please set LOG4CPLUS_ROOT to the root directory of log4cplus")
endif (NOT LOG4CPLUS_FOUND)	

# Set output variables
mark_as_advanced (LOG4CPLUS_INCLUDE_DIRS LOG4CPLUS_LIBRARIES)
