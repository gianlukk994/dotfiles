#!/bin/bash

filename='vscode_extension.txt'

while read line; do
    # reading each line
    code --install-extension $line
done < $filename