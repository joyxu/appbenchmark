#!/bin/bash

CURDIR=$(cd `dirname $0`; pwd)

pushd ${CURDIR}/ansible > /dev/null

ansible-playbook -i hosts run_test.yml  --user=wanglei --extra-vars "ansible_sudo_pass=wanglei"

popd > /dev/null

