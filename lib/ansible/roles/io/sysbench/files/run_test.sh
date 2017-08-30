#!/bin/bash

if [ -z "$(which sysbench 2>/dev/null)" ] ; then
    echo "Please install sysbench firstly !"
    exit 0
fi


CUR_DIR=$(cd `dirname $0`; pwd)

echo "Start fio test......"

FILE_SIZE="20G"

TEST_MODE="rndrw" 
#seqwr seqrewr seqrd rndrd rndwr rndrw

sysbench fileio --file-total-size=${FILE_SIZE} prepare
sysbench fileio --file-total-size=${FILE_SIZE} --file-test-mode=${TEST_MODE} --time=300 --max-requests=0  run >>result.log
sysbench fileio --file-total-size=${FILE_SIZE} cleanup

