#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Path to your Miniconda installation
CONDA_PATH="$SCRIPT_DIR/miniconda"

# Initialize Conda
if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
    source "$CONDA_PATH/etc/profile.d/conda.sh"
else
    echo "ERROR: Miniconda installation not found at $CONDA_PATH"
    exit 1
fi

# Activate the autogenstudio environment
conda activate autogenstudio

# Navigate to the script directory
cd "$SCRIPT_DIR"

# Run the autogenstudio command
autogenstudio ui --port 8081 --appdir "$SCRIPT_DIR/data"

# Deactivate the Conda environment
conda deactivate
