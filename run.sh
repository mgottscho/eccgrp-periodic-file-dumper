#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

tar -czf testcase.tar.gz ../dpcs-gem5/ &
./periodic_file_dump.sh testcase.tar.gz 10 5 .
