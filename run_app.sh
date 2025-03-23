#!/bin/bash
command=$1
app_name=$2

function run() {
    cd apps/$app_name
    echo "Running $app_name with args: ${@}"
    uv run main.py "${@}"
}

function lint() {
    cd apps/$app_name
    uv add --dev ruff
    uv run ruff check .
}


case $command in
    run)
        run "${@:3}"
        ;;
    lint)
        lint
        ;;
    *)
        echo "Invalid command"
        exit 1
        ;;
esac
