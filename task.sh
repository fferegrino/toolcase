#!/bin/bash

# Contains all the tasks that can be run
# locally to aid in development of this
# project

IMAGE_NAME=toolcase

function build() {
    # Default first argument to toolcase
    image_tag=${1:-toolcase}
	docker build -t $IMAGE_NAME .
}

function bash() {
    docker run -it --rm --entrypoint '' $IMAGE_NAME bash
}

function _lint() {
    directory=$1
    uv run --directory $directory ruff format --check
    uv run --directory $directory ruff check .
    uv run --directory $directory mypy .
}

function _fmt() {
    directory=$1
    echo "Formatting $directory"
    uv run --directory $directory ruff check . --fix
    uv run --directory $directory ruff format
}

function lint() {
    # Default first argument to toolcase
    app_name=$1
    if [ -z "$app_name" ]; then
        find apps -type f -name "pyproject.toml" \
             -maxdepth 2 -mindepth 2 -exec dirname {} \; | while read -r directory; do
            _lint $directory
        done
    elif [ "$app_name" == "library" ]; then
        _lint "library"
    else
        _lint "apps/$app_name"
    fi
}

function fmt() {
    # Default first argument to toolcase
    app_name=$1
    if [ -z "$app_name" ]; then
        find apps -type f -name "pyproject.toml" \
             -maxdepth 2 -mindepth 2 -exec dirname {} \; | while read -r directory; do
            _fmt $directory
        done
    elif [ "$app_name" == "library" ]; then
        _fmt "library"
    else
        _fmt "apps/$app_name"
    fi
}

$@
