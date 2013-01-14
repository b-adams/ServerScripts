#!/bin/bash

cd /Users/$1
mkdir Sites
cd Sites
mkdir doxygen
cd doxygen
mkdir cs131
cd /Users/$1/cs131
doxygen ../cs131_inclass_files/Doxyfile_cs131_12Fa
