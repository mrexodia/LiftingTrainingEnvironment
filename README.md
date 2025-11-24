# LiftingTrainingEnvironment

Empty training environment to prepare things locally. Just follow the instruction below :)

## Setting up the environment

This repository uses a [`devcontainer.json`](./.devcontainer/devcontainer.json) file to allow you to quickly get started.

### 1) GitHub Codespaces

**Using Codespaces is required for the training**

1. [Fork this repository](https://github.com/mrexodia/LiftingTrainingEnvironment/fork)
2. Click the green `<> Code` button
3. Press `...` and then `New with options...`
4. Change `Machine type` to `4-core`
5. Then `Create codespace`
6. Wait a ~5 minutes while the image is loading ☕

Troubleshooting:
- **Firefox (specifically on Linux) often does not work, try Chrome!**
- Reload the page if
  - Syntax highlighting fails to work
  - Startup takes too long
- If pasting from the clipboard fails, explicitly grant permission (settings icon on the left of the URL)
- **Remember**: save files before trying to recompile!

| ![](.devcontainer/new-codespace.png) | ![](.devcontainer/machine-type.png) |
|---|---|

#### **Remember to shut down your codespace [here](https://github.com/codespaces) when you're finished.**

I recommend switching to the `GitHub Dark` theme, because the syntax highlighting works better there.

When prompted by the CMake tools, just close the notifications:

![](.devcontainer/cmake-notifications.png)

### 2) Locally with Docker Desktop

<details>

<summary><sub>At a later date you can set things up locally with Docker Desktop</sub></summary>

- Install/Update [Docker Desktop](https://www.docker.com/products/docker-desktop/) ([alternatives](https://code.visualstudio.com/remote/advancedcontainers/docker-options))
- **Start Docker Desktop**
- Install [Visual Studio Code](https://code.visualstudio.com)
- Clone and open this repository in VS Code (**use the HTTPS protocol**)
- Install the [Dev Containers](vscode:extension/ms-vscode-remote.remote-containers) extension in VS Code (you should be prompted for recommended extensions)
- Click the blue 'Reopen in Container' button when prompted (you can also find it in the command palette)

For more detailed steps, check out the [Dev Containers tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial). The instructions after this assume you are running _inside_ the container.

#### Windows

Because the host filesystem is mounted inside the container you _may_ need to configure Git to not automatically convert line endings:

```sh
git config --global core.autocrlf false
```

Additionally it's recommended to configure Docker to use the WSL 2 backend.

</details>

## Building the tools

To build the project, press the `Build` button in the status bar:

![](.devcontainer/build-button.png)

You will be prompted for a preset, select `clang` and the build will start:

![](.devcontainer/select-preset.png)

Alternatively you can build with the following commands:

```sh
cmake --preset clang
cmake --build build
```

## Checking the environment

To verify if the environment is set up correctly, run:

```sh
llvm-config --prefix
```

Expected output:

> `/usr/local`

The `${workspaceFolder}/build` directory will also be added to your `PATH`, so you can easily access your tools from anywhere. To verify, run the following command:

```sh
remill-example
```

Expected output:

```sh
; Function Attrs: inlinehint nounwind
define ptr @lifted_example(ptr noalias %state, i64 %program_counter, ptr noalias %memory) #15 {
  %RCX = getelementptr inbounds %struct.State, ptr %state, i32 0, i32 0, i32 6, i32 5, i32 0, i32 0, !remill_register !7
  %BRANCH_TAKEN = alloca i8, align 1
  %RETURN_PC = alloca i64, align 8
  %MONITOR = alloca i64, align 8
  store i64 0, ptr %MONITOR, align 8
  %STATE = alloca ptr, align 8
  store ptr %state, ptr %STATE, align 8
  %MEMORY = alloca ptr, align 8
  store ptr %memory, ptr %MEMORY, align 8
  %NEXT_PC = alloca i64, align 8
  store i64 %program_counter, ptr %NEXT_PC, align 8
  %PC = getelementptr inbounds %struct.State, ptr %state, i32 0, i32 0, i32 6, i32 33, i32 0, i32 0, !remill_register !8
  %CSBASE = alloca i64, align 8
  store i64 0, ptr %CSBASE, align 8
  %SSBASE = alloca i64, align 8
  store i64 0, ptr %SSBASE, align 8
  %ESBASE = alloca i64, align 8
  store i64 0, ptr %ESBASE, align 8
  %DSBASE = alloca i64, align 8
  store i64 0, ptr %DSBASE, align 8
  %1 = load i64, ptr %NEXT_PC, align 8
  store i64 %1, ptr %PC, align 8
  %2 = add i64 %1, 7
  store i64 %2, ptr %NEXT_PC, align 8
  %3 = load ptr, ptr %MEMORY, align 8
  store i64 1337, ptr %RCX, align 8, !tbaa !9
  store ptr %3, ptr %MEMORY, align 8
  %4 = load ptr, ptr %MEMORY, align 8
  ret ptr %4
}
```
