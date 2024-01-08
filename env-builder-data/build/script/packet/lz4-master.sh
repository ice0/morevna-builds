DEPS=""

PK_DIRNAME="lz4"
PK_URL="https://github.com/Cyan4973/$PK_DIRNAME.git"
PK_GIT_CHECKOUT="tags/v1.9.4"
PK_LICENSE_FILES="LICENSE lib/LICENSE programs/COPYING tests/COPYING examples/COPYING"

source $INCLUDE_SCRIPT_DIR/inc-pkall-git.sh

local LOCAL_OPTIONS=
if [ "$PLATFORM" = "win" ]; then
    LOCAL_OPTIONS="$LOCAL_OPTIONS BUILD_STATIC=no CC=${HOST}-gcc WINDRES=${HOST}-windres TARGET_OS=Windows_NT EXT='.exe'"
#    echo "LOCAL_OPTIONS: ${LOCAL_OPTIONS}"
fi


pkbuild() {
    cd "$BUILD_PACKET_DIR/$PK_DIRNAME"

    if ! PREFIX=${INSTALL_PACKET_DIR} make ${LOCAL_OPTIONS} -j${THREADS}; then
        return 1
    fi
}

pkinstall() {
    cd "$BUILD_PACKET_DIR/$PK_DIRNAME"
    if ! PREFIX=${INSTALL_PACKET_DIR} make ${LOCAL_OPTIONS} install; then
        return 1
    fi
}
