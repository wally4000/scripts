git clone https://github.com/jonof/jfduke3d --depth=1
cd jfduke3d
git submodule update --init
DATADIR=. USE_POLYMOST=1  USE_OPENGL=USE_GLES2 make

mkdir $(HOME)/jfduke3d

