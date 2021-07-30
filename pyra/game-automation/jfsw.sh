git clone https://github.com/jonof/jfsw --depth=1
git submodule update --init
DATADIR=. USE_POLYMOST=1  USE_OPENGL=USE_GLES2 make

mkdir $(HOME)/shadoww
mv sw $(HOME/shadoww

