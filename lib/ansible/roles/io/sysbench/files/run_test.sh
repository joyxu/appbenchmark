#!/bin/bash

if [ -z "$(which sysbench 2>/dev/null)" ] ; then
    echo "Please install sysbench firstly !"
    exit 0
fi


CUR_DIR=$(cd `dirname $0`; pwd)

echo "Start fio test......"

FILE_SIZE="120G"

TEST_MODE="rndrw" 
TIME= 300

#seqwr seqrewr seqrd rndrd rndwr rndrw

sysbench fileio --file-total-size=${FILE_SIZE} prepare
nohup sysbench fileio --file-total-size=${FILE_SIZE} --file-test-mode=${TEST_MODE} --time=${TIME} --max-requests=0 run  2>&1 &
sleep ${TIME}
sysbench fileio --file-total-size=${FILE_SIZE} cleanup

