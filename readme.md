# toolcase

An example of a Docker image harbouring multiple Python apps that depend on a single library.

## Development

This project relies heavily on the `uv` tool. To install it, check the documentation on how to install it [here](https://docs.astral.sh/uv/getting-started/installation/).

## Working with the shared library

The shared library is located in the `library` folder; it is a _uv_ project that follows the `src` layout.

## Adding a new app

To create a new app, you can use the `task.sh` script:

```bash
./task.sh new <app_name>
```

This will:
1. Create a new folder for the app under `apps/<app_name>`.
2. Initialize a new `uv` project with Python 3.11.
3. Remove the default `hello.py` file and replace it with a `main.py` file containing a simple `main()` function.
4. Add development dependencies (`ruff`, `mypy`, and `pytest`).
5. Create a `tests` folder with a basic test file.

### Adding a dependency to the shared library (optional)

If your app needs to use the shared library, you can add it as a dependency:

```bash
uv add ../../library
```

Make sure you run this command from the app's folder.

## Running tasks

The `task.sh` script provides several tasks to aid in development:

### Build the Docker image

To build the Docker image:

```bash
./task.sh build
```

### Run a bash shell in the Docker container

To open a bash shell inside the Docker container:

```bash
./task.sh bash
```

### Run the Docker container

To run the Docker container with specific arguments:

```bash
./task.sh run <app_name> <args>
```

### Linting

To lint all apps or a specific app:

```bash
# Lint all apps
./task.sh lint

# Lint a specific app
./task.sh lint <app_name>

# Lint the shared library
./task.sh lint library
```

This will run `ruff` and `mypy` checks on the specified app or library.

### Formatting

To format all apps or a specific app:

```bash
# Format all apps
./task.sh fmt

# Format a specific app
./task.sh fmt <app_name>

# Format the shared library
./task.sh fmt library
```

This will run `ruff` to fix formatting issues in the specified app or library.
