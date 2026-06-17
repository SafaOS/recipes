#!/usr/bin/env bash

mkdir -p $output_prefix/etc/timidity
cp eawpats.cfg $output_prefix/etc/timidity
cp timidity.cfg $output_prefix/etc

wget https://ftpmirror1.infania.net/pub/idgames/sounds/eawpats.zip -O eawpats.zip
wget https://musical-artifacts.com/artifacts/3101/eawpats.sf2 -O eawpats.sf2

eawpats_zip_path="$(pwd)/eawpats.zip"
mkdir -p $output_prefix/usr/sounds/sf2
cp eawpats.sf2 $output_prefix/usr/sounds/sf2/
cp README.txt $output_prefix

cd $output_prefix/usr/sounds/sf2/
unzip $eawpats_zip_path
