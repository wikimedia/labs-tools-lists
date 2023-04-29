#!/bin/bash

# clean-up directories if they already exist
rm -fdr venv

# create a virtual environment
python3 -m venv venv

# activate it
source venv/bin/activate

# install dependencies
pip install --upgrade pip setuptools wheel
pip install pymysql