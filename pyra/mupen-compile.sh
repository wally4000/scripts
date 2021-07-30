#!/bin/bash
#TODO:
# Enable multiple video plugin sources
# Enable Python
# Separate video sources into separate Variable
# If repos exist, do git update instead #CISmart
# Add option for num_cpus

BUILD=Mupen64Plus-$(arch)
PATHS="PREFIX=. SHAREDIR=. LIBDIR=. INCDIR=." #This doesn't really work.
BUILDOPTS="USE_GLES=1 NEON=1 VFP_HARD=1 -j2"
EXTRAOPTS="NEW_DYNAREC=1"
DEBUGOPTS="DEBUG=1 V=1"
REPOS="ui-console core input-sdl rsp-hle audio-sdl video-rice" ##todo add more repos 
SGXLD="-L /opt/omap5-sgx-ddk-um-linux/lib"
SGXINC"-I /opt/omap5-sgx-ddk-um-linux/include"
mkdir $BUILD

#Clone repos
for repo in $REPOS
do
    if [ -d mupen64plus-$repo ]; then
        git -C mupen64plus-$repo pull --ff-only
    else
        git clone https://github.com/mupen64plus/mupen64plus-$repo --depth=1
    fi

        make -C mupen64plus-$repo/projects/unix all $BUILDOPTS $DEBUGOPTS
        cp -r mupen64plus-$repo/projects/unix/mupen* $BUILD ## Assume everything begins with Mupen.. A bit hackish but it works
        cp mupen64plus-core/projects/unix/libmu* $BUILD

        ## Copy any data directory to build directory
    if [ -d mupen64plus-$repo/data ] ; then
        cp mupen64plus-$repo/data/* $BUILD
    fi
$SGXLD $SGXINC  make -C mupen64plus-$repo/projects/unix clean ## clean up for next build

    done
