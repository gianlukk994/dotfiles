#!/bin/bash

source './utils.sh'

fancy_echo "\n <<< Starting Homebrew Setup >>> \n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"