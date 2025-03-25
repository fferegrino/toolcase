#!/bin/bash

# This file is meant to be run from within the container.

app_name=$1

uv run --directory apps/$app_name main.py "${@:2}"
