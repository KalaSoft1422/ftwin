srcDir :=  ${PWD}/..
incDir := ${PWD}/../include
FREETYPE_SRC_PATH := ${srcDir}/
srcs := ${FREETYPE_SRC_PATH}src/autofit/autofit.c \
	 ${FREETYPE_SRC_PATH}src/base/ftbase.c \
	 ${FREETYPE_SRC_PATH}src/base/ftbbox.c \
	${FREETYPE_SRC_PATH}src/base/ftbdf.c \
	${FREETYPE_SRC_PATH}src/base/ftbitmap.c \
	 ${FREETYPE_SRC_PATH}src/base/ftcid.c \
	 ${FREETYPE_SRC_PATH}src/base/ftfntfmt.c \
   ${FREETYPE_SRC_PATH}src/base/ftfstype.C \
	 ${FREETYPE_SRC_PATH}src/base/ftgasp.c \
	 ${FREETYPE_SRC_PATH}src/base/ftglyph.c \
	 ${FREETYPE_SRC_PATH}src/base/ftgxval.c \
	 ${FREETYPE_SRC_PATH}src/base/ftinit.c \
	 ${FREETYPE_SRC_PATH}src/base/ftdebug.c \
	 ${FREETYPE_SRC_PATH}src/base/ftlcdfil.c \
	 ${FREETYPE_SRC_PATH}src/base/ftmm.c \
	 ${FREETYPE_SRC_PATH}src/base/ftotval.c \
	 ${FREETYPE_SRC_PATH}src/base/ftpatent.c \
	 ${FREETYPE_SRC_PATH}src/base/ftpfr.c \
	 ${FREETYPE_SRC_PATH}src/base/ftstroke.c \
	 ${FREETYPE_SRC_PATH}src/base/ftsynth.c  \
	 ${FREETYPE_SRC_PATH}src/base/ftsystem.c \
	 ${FREETYPE_SRC_PATH}src/base/fttype1.c \
	 ${FREETYPE_SRC_PATH}src/base/ftwinfnt.c \
	 ${FREETYPE_SRC_PATH}src/bdf/bdf.c \
	 ${FREETYPE_SRC_PATH}src/bzip2/ftbzip2.c \
	 ${FREETYPE_SRC_PATH}src/cache/ftcache.c \
	 ${FREETYPE_SRC_PATH}src/cff/cff.c \
	 ${FREETYPE_SRC_PATH}src/cid/type1cid.c \
	 ${FREETYPE_SRC_PATH}src/gzip/ftgzip.c \
	 ${FREETYPE_SRC_PATH}src/lzw/ftlzw.c \
	 ${FREETYPE_SRC_PATH}src/pcf/pcf.c \
	 ${FREETYPE_SRC_PATH}src/pfr/pfr.c \
	 ${FREETYPE_SRC_PATH}src/psaux/psaux.c \
	 ${FREETYPE_SRC_PATH}src/pshinter/pshinter.c \
	 ${FREETYPE_SRC_PATH}src/psnames/psnames.c \
	 ${FREETYPE_SRC_PATH}src/raster/raster.c \
	 ${FREETYPE_SRC_PATH}src/sfnt/sfnt.c \
	 ${FREETYPE_SRC_PATH}src/smooth/smooth.c \
	 ${FREETYPE_SRC_PATH}src/truetype/truetype.c \
	 ${FREETYPE_SRC_PATH}src/type1/type1.c \
	 ${FREETYPE_SRC_PATH}src/type42/type42.c \
	 ${FREETYPE_SRC_PATH}src/winfonts/winfnt.c \
#change ABI aND TARGET for all android architecture (diff for armabi-v7a check androidndk website
ndkDir := /home/boom/Desktop/ndk
TOOLCHAIN := ${ndkDir}/toolchains/llvm/prebuilt/linux-x86_64
API := 21
ifeq ($(TARGETNO),1)              #BOTTOM TO TOP
ABI := x86_64
TARGET := x86_64-linux-android
endif
ifeq ($(TARGETNO),2)
ABI := x86
TARGET := i686-linux-android
endif
ifeq ($(TARGETNO),3)
ABI := arm64-v8a
TARGET := aarch64-linux-android
endif
ifeq ($(TARGETNO),4)
ABI := armeabi-v7a
TARGET := armv7a-linux-androideabi
endif
CC :=${TOOLCHAIN}/bin/${TARGET}${API}-clang
ifeq ($(TARGETNO),4)
TARGET :=  arm-linux-androideabi
endif
AR :=${TOOLCHAIN}/bin/${TARGET}-ar
RANLIB :=${TOOLCHAIN}/bin/${TARGET}-ranlib

.ONESHELL:

all:
	rmdir -v ${ABI}
	mkdir -v -p  ${ABI}
	${CC} -c ${srcs} -DANDROID_NDK -DFT2_BUILD_LIBRARY=1 -I${incDir} ${incDir}/ft2build.h -fPIC; \
	${AR} rc ./${ABI}/libft.a *.o; \
	${RANLIB} ./${ABI}/libft.a; \
	rm *.o
