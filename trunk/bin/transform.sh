#!/bin/bash
# 1) result file
# 2) source file
# 3) transform
# 4) parameters
java -jar ~/Library/Saxon/saxon9.jar -t -o $1 $2 $3 $4
