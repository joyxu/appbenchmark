#!/bin/bash

<<<<<<< HEAD
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
=======
if [ -z "$(which fio 2>/dev/null)" ] ; then
    echo "Please install sysbench firstly !"
    exit 0
fi
if [ -z "$(which ifconfig 2>/dev/null)" ] ; then
    echo "Please install net-tools firstly !"
    yum install net-tools -y
    exit 0
fi

IP=`ifconfig eth0|sed -n 2p|awk  '{ print $2 }'|tr -d 'addr:'`;
CUR_DIR=$(cd `dirname $0`; pwd)
if [ -d "${CUR_DIR}/result" ]; then
  rm -rf ${CUR_DIR}/result
fi
SLEEPTIME=315
pushd ${CUR_DIR} > /dev/null
sh rndread.sh 
sleep ${SLEEPTIME} 
sh rndrw.sh
sleep ${SLEEPTIME} 
sh  rndwrite.sh
sleep ${SLEEPTIME}
sh seqread.sh 
sleep ${SLEEPTIME}
sh seqwrite.sh
sleep ${SLEEPTIME}
popd > /dev/null






>>>>>>> upstream/master

