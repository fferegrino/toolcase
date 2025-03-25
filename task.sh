#!/bin/bash

# Contains all the tasks that can be run locally to aid 
# in development of this project.

IMAGE_NAME=toolcase
PYTHON_VERSION=3.11

function build() {
	docker build -t $IMAGE_NAME .
}

function bash() {
    docker run -it --rm --entrypoint '' $IMAGE_NAME bash
}

function run() {
    docker run -it --rm $IMAGE_NAME $@
}

function new() {
    app_name=$1
    if [ -z "$app_name" ]; then
        echo "Error: Please provide the name of the new app."
        return 1
    fi

    app_dir="apps/$app_name"

    # Step 1: Create the app folder
    mkdir -p $app_dir
    cd $app_dir || exit

    # Step 2: Initialize a new uv project
    uv init --python $PYTHON_VERSION

    # Step 3: Delete the default hello.py file
    rm hello.py

    # Step 4: Add a main.py file
    echo -e "def main() -> None:\n    print(\"Hello, World!\")\n\n" > main.py
    echo -e "if __name__ == \"__main__\":\n    main()" >> main.py

    # Step 5: Add development dependencies
    uv add --dev ruff mypy pytest

    # Step 6: Add a test file
    mkdir -p tests
    echo -e "def test_main():\n    assert True" > tests/test_main.py

    echo "New app '$app_name' created successfully in $app_dir."
}

function lint() {
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

function _lint() {
    directory=$1
    uv run --directory $directory ruff format --check
    uv run --directory $directory ruff check .
    uv run --directory $directory mypy --strict .
}

function _fmt() {
    directory=$1
    echo "Formatting $directory"
    uv run --directory $directory ruff check . --fix
    uv run --directory $directory ruff format
}

$@
