#!/bin/bash

set -euxo pipefail

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

rm -rf ab
mkdir ab

cutoff=12000

for f in *.flac *.wav; do
  if [[ $(($RANDOM % 2)) == 0 ]]; then
    ffmpeg -i $f -filter:a "lowpass=f=$cutoff" ab/"$f.a.wav"
    ffmpeg -i $f ab/"$f.b.wav"
  else
    ffmpeg -i $f -filter:a "lowpass=f=$cutoff" ab/"$f.b.wav"
    ffmpeg -i $f ab/"$f.a.wav"
  fi
done
