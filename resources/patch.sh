#! /bin/sh

LUA_HOME="${HOME}/repos/lua"
PROJECT_DIR="${LUA_HOME}/luatex_api_all"
LIBRARY="${PROJECT_DIR}/library"

_patch() {
  local ENGINE="$1"
  local PROJECT="$2"
  local FILENAME="$3"
  wget \
    --quiet \
    --output-document "${PROJECT_DIR}/library/${ENGINE}/${FILENAME}.lua" \
    "https://raw.githubusercontent.com/LuaCATS/${PROJECT}/main/library/${FILENAME}.lua"

  if [ "$?" -ne 0 ]; then
    echo "Error downloading file https://raw.githubusercontent.com/LuaCATS/${PROJECT}/main/library/${FILENAME}.lua"
  fi

  patch \
    "${PROJECT_DIR}/library/${ENGINE}/${FILENAME}.lua" < \
    "${PROJECT_DIR}/resources/patches/${ENGINE}/${FILENAME}.diff"

  if [ "$?" -ne 0 ]; then
    echo "Error patching file ${PROJECT_DIR}/library/${ENGINE}/${FILENAME}.lua"
  fi

}

_patch luatex lpeg          lpeg
_patch luatex luafilesystem lfs
_patch luatex lzlib         zlib
_patch luatex md5           md5
_patch luatex luaharfbuzz   luaharfbuzz
_patch luatex luasocket     mbox
_patch luatex luasocket     mime
_patch luatex luasocket     socket
_patch luatex slnunicode    unicode
_patch luatex luazip        zip
