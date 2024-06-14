#!/bin/bash

props="$HOME/.termux/termux.properties"

mv "$props" "$props-tmp"
mv "$props-2" "$props"
mv "$props-tmp" "$props-2"

termux-reload-settings

echo "Tip: Re-open Termux to fix fullscreen issue"
