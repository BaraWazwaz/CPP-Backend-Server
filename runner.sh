#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo -e "error: expected [\"run\", \"build\", \"clean\"]"
    exit 1
fi

case "$1" in
    'run')
        if [[ ! -f ./build/MyServer.exe ]]; then
            ./runner.sh build
        fi
        PATH="/c/msys64/ucrt64/bin:$PATH" ./build/MyServer.exe
        ;;
    'build')
        cmake --build ./build
        ;;
    'clean')
        rm -fr ./build
        ;;
    *)
        echo -e "error: expected \"run\" or \"build\""
        exit 1
        ;;
esac
