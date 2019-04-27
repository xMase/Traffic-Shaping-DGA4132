#!/bin/sh  

tar -czvf "release/`date +%Y_%m_%d_``date +%s`.tar.gz" \
          "etc/" \
          "usr/" \
          "setup.sh" \
          "LICENSE" \
          "README.md"

