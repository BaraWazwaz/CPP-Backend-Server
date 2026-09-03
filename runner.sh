#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo -e "error: expected \"run\" or \"compile\""
    exit 1
fi

case "$1" in
    'run')
        if [[ ! -f main.exe ]]; then
            g++ main.cpp -o main.exe
        fi
        ./main.exe
        ;;
    'compile')
        g++ main.cpp -o main.exe
        ;;
    *)
        echo -e "error: expected \"run\" or \"compile\""
        exit 1
        ;;
esac
