LuaJIT-iOS-Framework
====================

LuaJIT iOS Framework script

Will compile an iOS Framework from LuaJIT's source code.

Requires lua 5.1 to be installed on your machine, __XCode 4.2/iOS 5.1__ or greater

BUILD
-----
1. downlaod the [source](http://luajit.org/download.html) of LuaJIT
2. extract source files and copy them to directory __"LuaJIT-iOS-Framework/luajit-2.0"__
3. run the [__luajit.sh__](luajit.sh) (or [__luajit-iOS6.1.sh__](luajit-iOS6.1.sh) for iOS6.1) script and you will get the framework


INSTALLATION
------------

+ Just drop the framework into your project. 
+ You will have to refer to \<LuaJIT/lua.h\> instead of "lua.h", etc
+ You can create a lua.h file which just does #include \<LuaJIT/lua.h\> if you have legacy code that uses lua.h
+ (maybe) You will also need to include /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/llvm-gcc-4.2/lib/gcc/arm-apple-darwin10/4.2.1/libgcc.a or you will get linker errors when compiling for Device.


ISSUES
------

I attached a Demo project at __"LuaJIT-iOS-Framework/Demo/LuaJITDemo.zip"__ , (maybe) you should try to run it in Xcode.

If there is any problems when using this, read the [LuaJIT Install Page](http://luajit.org/install.html) , read the [lua C API](http://www.lua.org/manual/5.2/manual.html#4), or contact [me](https://github.com/ziggear) via github

