# C Project Skeleton

Launch a new C application or library with guardrails already in place: sane defaults, fast builds, colored logs, and a minimal testing harness. Drop this template in, name your binary, and start shipping code.

## Why C devs like this template
- Zero-guesswork Makefile with separate build/test targets, release/debug modes, and colorized output.
- Clean directory layout (`src`, `include`, `tests`, `build`, `bin`) so headers, sources, and artifacts never mix.
- Opt-in `.buildinfo` metadata lets you brand releases without touching the Makefile.
- Batteries-included test runner that links everything under `tests/` automatically.

## Prerequisites
- GCC or Clang (anything that understands `-Wall -Wextra -O2`).
- GNU Make 4.x+ (or compatible).
- Git (if you plan to fork or keep history).

## 1. Create your own repository
Pick the flow that matches how you host your code.

### Option A – GitHub “Use this template”
1. Open the template repository in your browser.
2. Click **Use this template → Create a new repository**.
3. Choose a name, mark it private/public, and confirm.
4. Clone your brand-new repository locally and you’re ready to edit.

### Option B – Manual clone & clean history
```bash
git clone <template-url> my-c-project
cd my-c-project
rm -rf .git
git init
git add .
git commit -m "Bootstrap from c-project-skeleton"
git remote add origin <your-origin-url>
```
Now push the repository wherever you host code.

## 2. Personalize the project identity
The Makefile reads `.buildinfo` if it exists. Drop one in the repo root to override defaults without editing build logic:

```make
PROJECT_NAME   = Stellar Sensor Node
PROJECT_BIN    = sensorctl
PROJECT_VER    = 0.3.0
PROJECT_AUTHOR = Ada Lovelace
BUILD_MODE     = debug        # or release
CC             = clang
```

## 3. Build, run, and test

```bash
make         # compile sources into bin/<PROJECT_BIN>
make run     # build + execute the binary
make test    # compile and run tests in tests/
make clean   # remove bin/ and build/
```

Set `BUILD_MODE=debug` or `BUILD_MODE=release` (defaults to release). You can export it (`export BUILD_MODE=debug`) or place it in `.buildinfo`.

## Project layout

```
.
├── include/        # Public headers consumed by src/ and tests/
├── src/            # Application sources; add more .c files freely
├── tests/          # Test sources; linked into bin/test_runner
├── build/          # Object files (generated)
├── bin/            # Final executables (generated)
└── Makefile        # One-stop build orchestration
```

## Recommended workflow
| Step | Command | What it gives you |
|------|---------|-------------------|
| Edit | `$EDITOR src/main.c include/*.h` | Implement features or APIs. |
| Compile fast | `make` | Rebuild only what changed. |
| Smoke test | `make run` | Run the freshly built binary with colored logs. |
| Add tests | `touch tests/foo_test.c` + code | Test files auto-link—no Makefile edits. |
| Continuous feedback | `BUILD_MODE=debug make test` | Debug flags + assertions enabled. |
| Clean slate | `make clean` | Remove artifacts before packaging or switching targets. |

## Extending the template
- **New modules**: drop a `foo.c` in `src/`, declare the interface in `include/foo.h`, and include it where needed—Make handles the rest.
- **Static libraries**: add `ar` or `pkg-config` flags inside the Makefile’s `CFLAGS_BASE` or link step.
- **Code quality**: wire in `clang-format`, `clang-tidy`, or `cppcheck` as new Make targets (e.g., `make lint`).
- **CI ready**: call `make`, `make test`, and optionally `make clean` inside your CI pipeline for deterministic builds.

## Troubleshooting
- **Missing compiler**: run `gcc --version` or `clang --version`; install one if missing.
- **Stale objects**: when switching branches or compilers, run `make clean` to avoid ABI mismatches.
- **Header include paths**: keep headers under `include/` and compile sources with `#include "foo.h"`—`-Iinclude` is already wired in.
- **Tests not running**: ensure every test file has a `main()` or uses a shared test runner entry point.

## License
State your license of choice (MIT, Apache-2.0, etc.) so downstream teams know how they can use your code.
