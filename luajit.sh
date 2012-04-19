LUAJIT=luajit-2.0
DEVDIR=/Applications/Xcode.app/Contents/Developer/Platforms
IOSVER=iPhoneOS5.1.sdk
SIMVER=iPhoneSimulator5.1.sdk
IOSDIR=$DEVDIR/iPhoneOS.platform/Developer
SIMDIR=$DEVDIR/iPhoneSimulator.platform/Developer
IOSBIN=$IOSDIR/usr/bin/
SIMBIN=$SIMDIR/usr/bin/

BUILD_DIR=build

FRAMEWORK_NAME=LuaJIT
FRAMEWORK_DIR=$FRAMEWORK_NAME.framework
rm -rf $FRAMEWORK_DIR
rm -rf $BUILD_DIR
rm *.a 1>/dev/null 2>/dev/null

mkdir -p $BUILD_DIR
 
make -j -C $LUAJIT HOST_CFLAGS="-arch i386" HOST_LDFLAGS="-arch i386" TARGET_SYS=iOS TARGET=arm cleaner
make -C $LUAJIT HOST_CFLAGS="-arch i386" HOST_LDFLAGS="-arch i386" TARGET_SYS=iOS TARGET=arm amalg CROSS=$IOSBIN TARGET_FLAGS="-isysroot $IOSDIR/SDKs/$IOSVER -arch armv7"
mv $LUAJIT/src/libluajit.a $BUILD_DIR/libluajitA7.a
make -j -C $LUAJIT HOST_CFLAGS="-arch i386" HOST_LDFLAGS="-arch i386" TARGET_SYS=iOS TARGET=arm cleaner
make -j -C $LUAJIT HOST_CFLAGS="-arch i386" HOST_LDFLAGS="-arch i386" TARGET_SYS=iOS TARGET=arm amalg CROSS=$IOSBIN TARGET_FLAGS="-isysroot $IOSDIR/SDKs/$IOSVER -arch armv6"
mv $LUAJIT/src/libluajit.a $BUILD_DIR/libluajitA6.a
make -j -C $LUAJIT HOST_CFLAGS="-arch i386" HOST_LDFLAGS="-arch i386" TARGET_SYS=iOS TARGET=x86 cleaner
make -j -C $LUAJIT HOST_CFLAGS="-arch i386" HOST_LDFLAGS="-arch i386" TARGET_SYS=iOS TARGET=x86 amalg CROSS=$SIMBIN TARGET_FLAGS="-isysroot $SIMDIR/SDKs/$SIMVER -arch i386"
mv $LUAJIT/src/libluajit.a $BUILD_DIR/libluajit32.a


################################################################################
# Create iOS framework
mkdir -p $FRAMEWORK_DIR

# Combine all libraries into one - required for framework
libtool -o $FRAMEWORK_DIR/$FRAMEWORK_NAME $BUILD_DIR/*.a 2> /dev/null

# Copy public headers into framework
mkdir -p $FRAMEWORK_DIR/Headers
cp $LUAJIT/src/lua.h $FRAMEWORK_DIR/Headers
cp $LUAJIT/src/lauxlib.h $FRAMEWORK_DIR/Headers
cp $LUAJIT/src/lualib.h $FRAMEWORK_DIR/Headers
cp $LUAJIT/src/luajit.h $FRAMEWORK_DIR/Headers
cp $LUAJIT/src/lua.hpp $FRAMEWORK_DIR/Headers
cp $LUAJIT/src/luaconf.h $FRAMEWORK_DIR/Headers


# Fix-up header files to use standard framework-style include paths
for FILE in `find "$FRAMEWORK_DIR/Headers" -type f`
do
	sed -i "" "s:#include \"\(.*\)\":#include <$FRAMEWORK_NAME/\1>:" "$FILE"
done