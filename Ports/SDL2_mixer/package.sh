#!/usr/bin/env -S bash ../.port_include.sh
port=SDL2_mixer
version=2.0.4
useconfigure=true
files="https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-${version}.tar.gz SDL2_mixer-${version}.tar.gz a36e8410cac46b00a4d01752b32c3eb1"
auth_type=md5
depends="SDL2 libvorbis"

configure() {
    run ./configure \
        --host="${SERENITY_ARCH}-pc-serenity" \
        --with-sdl-prefix="${SERENITY_INSTALL_ROOT}/usr/local" \
        --enable-music-opus=false --enable-music-opus-shared=false \
        --enable-music-mod-modplug=false --enable-music-mod-modplug-shared=false \
        EXTRA_LDFLAGS="-lgui -lgfx -lipc -lcore -lcompression"
}

build() {
    run make -k
}

install() {
    run make -k DESTDIR="${SERENITY_INSTALL_ROOT}" install
    ${CC} -shared -o ${SERENITY_INSTALL_ROOT}/usr/local/lib/libSDL2_mixer.so -Wl,--whole-archive ${SERENITY_INSTALL_ROOT}/usr/local/lib/libSDL2_mixer.a -Wl,--no-whole-archive -Wl,--no-as-needed -lvorbis -lvorbisfile
    rm -f ${SERENITY_INSTALL_ROOT}/usr/local/lib/libSDL2_mixer.la
}
