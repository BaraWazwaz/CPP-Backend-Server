#!/usr/bin/env bash

export PATH="/c/msys64/ucrt64/bin:$PATH"

case "$1" in
    'run')
        if [[ ! -f "./build/app/$2" ]]; then
            ./project.sh build
        fi
        "./build/app/$2"
        ;;
    'build')
        cmake --build ./build
        ;;
    'clean')
        rm -fr ./build
        mkdir -p ./build
        cd ./build
        cmake ..
        cd ..
        ;;
    *)
        echo -e "error: expected [\"run\", \"build\", \"clean\"]"
        exit 1
        ;;
esac
