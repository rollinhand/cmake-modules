cmake-modules
=============

This is a repository with find_package modules.

The CMake modules and scripts are distributed under the BSD license.

Author: Björn Berg <bjoern dot berg at gmx dot net>


FindPebble.cmake
----------------
The find_package module for the Pebble SDK is something special. It should be combined
with the CMakeLists.pebble.txt to make your Pebble project ready for the usage with
Eclipse. The package also adds some specific Pebble targets to the Makefile so you can
start the emulator directly from Eclipse or install the application on your watch.

And this is how it works:
* Create a project with *pebble new-project --simple _projectname_*
* Create a directory called _cmake/modules_ inside the new project.
* Copy _FindPebble.cmake_ into _cmake/modules_.
* Copy _CMakeLists.pebble.cmake_ into your projects root directory and rename it to
CMakeLists.txt.
* Change the project name in CMakeLists.txt to match your projects name. But leave the C
in capital letters in place.
* Generate a Makefile with CMake like _cmake -G"Eclipse CDT4 - Unix Makefiles" 
-DPEBBLE_ROOT_DIR:FILEPATH=/opt/PebbleSDK-3.1_

You have to replace PEBBLE_ROOT_DIR with your root directory the SDK was installed to.

Happy coding with Eclipse.





