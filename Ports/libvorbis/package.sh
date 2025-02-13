#!/usr/bin/env -S bash ../.port_include.sh
port=libvorbis
version=1.3.7
useconfigure=true
files="https://github.com/xiph/vorbis/releases/download/v${version}/libvorbis-${version}.tar.gz libvorbis-${version}.tar.gz 9b8034da6edc1a17d18b9bc4542015c7"
auth_type=md5
depends=libogg

install() {
    run make DESTDIR=${SERENITY_INSTALL_ROOT} $installopts install
    ${CC} -shared -o ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbis.so -Wl,--whole-archive ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbis.a -Wl,--no-whole-archive -logg
    rm -f ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbis.la
    ${CC} -shared -o ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbisenc.so -Wl,--whole-archive ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbisenc.a -Wl,--no-whole-archive -lvorbis
    rm -f ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbisenc.la
    ${CC} -shared -o ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbisfile.so -Wl,--whole-archive ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbisfile.a -Wl,--no-whole-archive -lvorbis
    rm -f ${SERENITY_INSTALL_ROOT}/usr/local/lib/libvorbisfile.la
}
