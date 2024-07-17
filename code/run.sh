#!/usr/bin/env bash

R -e "install.packages('digest', repos='http://cran.rstudio.com/')"

#javac Compare.java
java Compare.java
python3.12 ./compare.py
Rscript ./compare.R
julia ./compare.jl
