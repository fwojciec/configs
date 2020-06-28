#!/bin/sh

TERMINFO_PATH="~/.terminfo"

for terminfo in *.terminfo do
	tic -o $terminfo
done
