#!/bin/bash
# Copyright 2017 SMB, MIT License

REPOS="gamecode smb-data.pk3dir smb-maps.pk3dir"
DEV_DIR=~/xonotic/smb
GMQCC_DIR=${DEV_DIR}/gmqcc
USER_DIR=~/.supermechanicalbros
DATA_DIR=${USER_DIR}/data

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
