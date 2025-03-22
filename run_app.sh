#!/bin/bash

app_name=$1

cd apps/$app_name

uv run main.py "${@:2}"
