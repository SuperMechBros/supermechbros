#!/bin/bash
# name: all.sh
# version: 0.2.0
# Copyright 2017 SMB, MIT License

BASE_DIR="$(cd "$(dirname "${0}")" && pwd -P)"

# Customize
REPOS="gamecode smb-data.pk3dir smb-maps.pk3dir"
DEV_DIR=${HOME}/xonotic/smb
USER_DIR=${HOME}/.supermechanicalbros
GMQCC_DIR=${DEV_DIR}/gmqcc
DATA_DIR=${USER_DIR}/data
SMB_BIN=darkplaces-sdl

# Internal Constants
SCRIPT_NAME=$(basename $0 .sh)
VERSION=$(awk 'NR == 3 {print $3; exit}' $0)

# Helpers
_check_dir() {
    local _dir=$1
    if [[ ! -d ${_dir} ]]; then
        echo "[ ERROR ] Unable to locate '${_dir}' directory."; exit 1
    fi
}

_fix_windows_path() {
    export PATH="$d0/misc/buildfiles/win64:$d0/d0_blind_id/.libs:$PATH"
}

_get_engine_dir() {
    relative_dir=${DEV_DIR}/supermechbros/darkplaces/
    _check_dir ${relative_dir}
    export SMB_DIR=$(cd ${relative_dir}; pwd)
}

_get_dev_dir() {
    relative_dir=$(dirname $0)/../
    _check_dir ${relative_dir}
    if [[ "$(cd $(dirname $0)/../; basename $(pwd))" == "smb" ]]; then
        export DEV_DIR=$(cd ${relative_dir}; pwd)
    else
        echo "the parent directory needs to be named 'smb', I guess."
        exit 1
    fi
}

smb_build() {

    mkdir -p ${DEV_DIR} && \
        cd ${DEV_DIR}

    # Clone or Update deps
    if [[ ! -d ${GMQCC_DIR} ]]; then
        git clone https://gitlab.com/xonotic/gmqcc.git && cd ${GMQCC_DIR}
    else
        cd ${GMQCC_DIR} && git fetch && git pull --rebase
    fi
    make
    cd -

    # Clone or Update
    for r in ${REPOS}; do
        if [[ ! -d ${r} ]]; then
            git clone git@github.com:SuperMechBros/${r}.git && \
            cd ${r}
        else
            cd ${r} && git fetch && git pull --rebase
        fi
        cd -
    done

    # Build
    cd ${DEV_DIR}/gamecode && \
        ./update.sh && \
        ./build.sh

    # Move mod
    mkdir -p ${DATA_DIR} && \
        cp *.dat ${DATA_DIR}
}

smb_update() {
    echo "git pull --rebase all the things!"
}

smb_run() {
    ${SMB_DIR}/${SMB_BIN} -smb $@
}

_version() {
    echo ${VERSION}
}

_help() {
    echo "./all.sh

FLAGS
    --version                                   prints the version string

COMMANDS

    build                                       update dependencies, builds everything
    run                                         runs Super Mechanical Bros.

EXAMPLES

    # update dependencies, builds everything
    ./all.sh build

    # runs the game
    ./all.sh run

    # Override the path to Super Mechnical Bros. engine (assumed from relative location of this script)
    SMB_DIR=\$HOME/some/other/dir; ./all.sh --version
"
}


# Init
######

# Allow for overriding the path assumption
# SMB_DIR=$HOME/some/other/dir; ./all.sh --version
if [[ -z ${SMB_DIR} ]]; then
    _get_engine_dir
else
    _check_dir ${SMB_DIR}
fi

case "`uname`" in
    MINGW*|Win*)        _fix_windows_path;
esac

case $1 in
    # flags
    '--version')        _version;;
    # commands
    'build')            smb_build;;
    'run')              smb_run $@;;
    # default
    *)                  _help; exit 0;;
esac
