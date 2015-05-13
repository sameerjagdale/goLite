#!/bin/bash

if [ ! -d 'gen' ]; then
	mkdir gen
fi
if [ ! -d 'bin' ]; then
	mkdir bin
fi
make

