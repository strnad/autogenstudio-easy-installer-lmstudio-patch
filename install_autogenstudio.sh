#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Path to your Miniconda installation
CONDA_PATH="$SCRIPT_DIR/miniconda"

# Check if Miniconda is already installed
if [ ! -d "$CONDA_PATH" ]; then
    # Download Miniconda installer
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

    # Install Miniconda
    bash miniconda.sh -b -p "$CONDA_PATH"

    # Clean up installer
    rm miniconda.sh
else
    echo "Miniconda is already installed in $CONDA_PATH. Skipping installation."
fi

# Initialize Conda for this script session only
if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
    source "$CONDA_PATH/etc/profile.d/conda.sh"
else
    echo "ERROR: Miniconda installation not found at $CONDA_PATH"
    exit 1
fi

# Remove the existing environment if it exists
conda remove --name autogenstudio --all -y

# Create a new environment
conda create -n autogenstudio python=3.11 -y

# Ensure the environment is activated and install the necessary packages
conda run -n autogenstudio conda install -y packaging
conda run -n autogenstudio pip install autogenstudio

# Create the data folder if it doesn't exist
DATA_DIR="$SCRIPT_DIR/data"
mkdir -p "$DATA_DIR"

# Patch the datamodel.py file
DATAMODEL_FILE="$CONDA_PATH/envs/autogenstudio/lib/python3.11/site-packages/autogenstudio/datamodel.py"
if [ -f "$DATAMODEL_FILE" ]; then
    sed -i 's/max_tokens: Optional\[int\] = None/max_tokens: Optional[int] = 4096/' "$DATAMODEL_FILE"
    echo "Patched $DATAMODEL_FILE successfully."
else
    echo "ERROR: $DATAMODEL_FILE not found."
    exit 1
fi
