LuaJIT-iOS-Framework
====================

LuaJIT iOS Framework script

Will compile an iOS Framework from LuaJIT's source code.

Requires lua 5.1 to be installed on your machine, XCode 4.2 or greater, and iOS 5.1 SDK

BUILD
-----
Just run the luajit.sh script after downloading the submodule

INSTALLATION
------------

+ Just drop the framework into your project. 
+ You will have to refer to \<LuaJIT/lua.h\> instead of "lua.h", etc
+ You can create a lua.h file which just does #include \<LuaJIT/lua.h\> if you have legacy code that uses lua.h
+ You will also need to include /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/llvm-gcc-4.2/lib/gcc/arm-apple-darwin10/4.2.1/libgcc.a or you will get linker errors when compiling for Device.


ISSUES
------
I have had a few crashes when using this, so it seems pretty experimental for now.

