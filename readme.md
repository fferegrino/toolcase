# toolcase

An example of a Docker image harbouring multiple Python apps that depend on a single library.

## Adding a new app

Create a new folder in the `apps` folder and _cd_ into it:

```bash
mkdir apps/my_cool_app
cd apps/my_cool_app
```

Initialise a new _uv_ project:

```bash
uv init
```

The above command should create some default files in your new app folder:

```text
.
├── README.md
├── hello.py
├── pyproject.toml
└── uv.lock
````

And you should be able to run your new script like:

```bash
uv run hello.py
```

Before moving on to writing your code, rename the `hello.py` file to `main.py`.

```bash
mv hello.py main.py
```

And add the following development dependencies:

```bash
uv add --dev ruff mypy pytest
```

And finally, add a test file to your repo:

```bash
mkdir tests/
echo "def test_main(): assert True" > tests/test_main.py
```
