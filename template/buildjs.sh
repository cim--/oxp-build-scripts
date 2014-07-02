#!/bin/bash
cat buildtmp/scriptheader.js $1 > $1.new 
mv $1.new $1;