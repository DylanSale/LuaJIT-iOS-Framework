LUAJIT=luajit-2.0
ISDK=`xcode-select -print-path`/Platforms/iPhoneOS.platform/Developer
ISDKVER=iPhoneOS6.1.sdk
ISDKP=$ISDK/usr/bin/
CC=/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/bin/llvm-gcc-4.2

cd $LUAJIT

rm -rf iOS
mkdir iOS
make HOST_CC="$CC -m32 -arch i386" CROSS=$ISDKP TARGET_FLAGS="-arch armv7 -isysroot $ISDK/SDKs/$ISDKVER" TARGET=arm TARGET_SYS=iOS clean all
cp -p src/libluajit.a iOS/libluajit-armv7.a
make CC="$CC -m32 -arch i386" clean all
cp -p src/libluajit.a iOS/libluajit-i386.a
make clean
lipo -create iOS/libluajit-*.a -output ../LuaJIT.framework/LuaJIT
rm iOS/libluajit-*.a
cp src/luajit.h src/luaconf.h src/lua.h src/lua.hpp src/lauxlib.h src/lualib.h ../LuaJIT.framework/Headers

cd ..
