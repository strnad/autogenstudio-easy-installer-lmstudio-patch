# AutoGen Studio Easy Installer with LM-Studio Patch

This repository contains scripts to install and run AutoGen Studio within a specified directory using Miniconda, with a specific patch to ensure compatibility with LM-Studio. The scripts ensure a clean installation without modifying the global system environment.

## What is AutoGen Studio?

AutoGen Studio is an innovative platform developed by Microsoft for creating and managing multi-agent workflows. It provides a user-friendly interface for designing, prototyping, and integrating various agents, enabling users to build complex, automated systems with ease. AutoGen Studio supports both no-code and low-code approaches, making it accessible for developers of all skill levels. It includes sections for building agent workflows, testing interactions, and storing development sessions for future reference.

## Why Use This Installer?

- **Isolated Environment**: The installer creates a dedicated Conda environment, ensuring that AutoGen Studio and its dependencies do not interfere with other software on your system.
- **Reproducibility**: Using Conda ensures that the environment can be easily replicated, which is crucial for collaborative projects and production deployments.
- **Easy Setup**: The provided scripts automate the installation and setup process, saving time and reducing the potential for configuration errors.
- **Customization**: The installer allows for easy customization, such as modifying default settings.

## Files

- `install_autogen.sh`: Script to install Miniconda, create the `autogenstudio` Conda environment, install necessary packages, and patch the `datamodel.py` file.
- `run_autogenstudio.sh`: Script to activate the `autogenstudio` environment and run the AutoGen Studio UI.

## Prerequisites

- Linux-based system
- Bash shell

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/strnad/autogenstudio-easy-installer-lmstudio-patch.git
    cd autogenstudio-easy-installer-lmstudio-patch
    ```

2. **Make the scripts executable:**
    ```bash
    chmod +x install_autogen.sh run_autogenstudio.sh
    ```

3. **Run the installation script:**
    ```bash
    ./install_autogen.sh
    ```

   This script will:
   - Download and install Miniconda in the current directory.
   - Create the `autogenstudio` Conda environment with Python 3.11.
   - Install the necessary packages.
   - Patch the `datamodel.py` file to set `max_tokens: Optional[int] = 4096`.

## Running AutoGen Studio

1. **Run the AutoGen Studio UI:**
    ```bash
    ./run_autogenstudio.sh
    ```

   This script will:
   - Activate the `autogenstudio` environment.
   - Run the AutoGen Studio UI on port 8081.
   - Deactivate the Conda environment after the UI is closed.

## Patch for LM-Studio Compatibility

During the installation process, the script applies a patch to the `datamodel.py` file. This patch addresses a bug that was causing the model to generate only 2 tokens, preventing effective use of AutoGen Studio with LM-Studio. Specifically, it sets the default value of `max_tokens` to `4096`:

```python
max_tokens: Optional[int] = 4096

