#!/bin/bash

if [ -z "$(which sysbench 2>/dev/null)" ] ; then
    echo "Please install sysbench firstly !"
    exit 0
fi

CUR_DIR=$(cd `dirname $0`; pwd)
mkdir -p ${CUR_DIR}/result
IOTEST_DIR="${CUR_DIR}/result"
echo "Start fio test......"

FILE_SIZE="20G"

TEST_MODE=("rndrw" "rndwr" "rndrd" "seqrd" "seqrewr") 
TIME=300

#seqwr seqrewr seqrd rndrd rndwr rndrw
pushd ${IOTEST_DIR} > /dev/null

for var in "${TEST_MODE[@]}"
do 
	 sysbench fileio --file-total-size=${FILE_SIZE} prepare	
	 nohup sysbench fileio --file-total-size=${FILE_SIZE} --file-test-mode=$var --time=${TIME} --max-requests=0 run >$var.result  2>&1 &
	 sleep ${TIME}

done
sysbench fileio --file-total-size=${FILE_SIZE} cleanup
popd > /dev/null

