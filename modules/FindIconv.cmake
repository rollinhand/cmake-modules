# 	Find iconv library
#
#	Author: Björn Berg, bjoern.berg@gmx.de
#	Redistribution and use is allowed according to the terms of the BSD license.
# 	For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
#	ICONV_INCLUDE_DIRS	-	where to find iconv.h
#	ICONV_LIBRARIES		-	Lists of libraries when using iconv
#	ICONV_FOUND			-	True if iconv found
#

# Search for the header file
find_path( ICONV_INCLUDE_DIR NAMES iconv.h )

# Search for the library
set( ICONV_LIB_NAMES iconv libiconv iconv-2 libiconv-2 )
find_library( ICONV_LIBRARY NAMES ${ICONV_LIB_NAMES} )

# Copy results to output variables
set( ICONV_INCLUDE_DIRS ${ICONV_INCLUDE_DIR} )
set( ICONV_LIBRARIES ${ICONV_LIBRARY} )

if (ICONV_LIBRARY)
	set (ICONV_FOUND true)
endif (ICONV_LIBRARY)	

# Set output variables
mark_as_advanced (ICONV_INCLUDE_DIRS ICONV_LIBRARIES)