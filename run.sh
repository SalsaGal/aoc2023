#!/bin/zsh

if (( ${1} )); then
  target=$1
else
  target=$(ls -t | grep "[0-9]")
fi

ghc $target/Main.hs -o bin/$target -outputdir bin
bin/$target
