#!/bin/bash

if [[ $1 -eq 0 ]]; then
  target=$(ls -t | grep "[0-9]" | head -n1)
else
  target=$1
fi

echo "Target: $target"

if [[ ! -d "bin" ]]; then
  echo "Making bin"
  mkdir bin
fi

ghc $target/Main.hs -o bin/$target -outputdir bin
cd $target
../bin/$target
