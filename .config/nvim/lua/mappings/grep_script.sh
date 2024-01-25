#!/usr/bin/bash


cat telescope.lua | sed "s/vim.*\('.*'\).*\('.*'\)\s*,\(.*\)\s*,\s*{\s*desc\s*=\s*\('.*'\)\s*,\(.*\)}.*/[\2] = {\4,\1,\3,{\5}}/"

