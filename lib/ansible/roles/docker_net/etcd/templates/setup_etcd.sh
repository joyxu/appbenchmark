#!/bin/bash

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/coreos/etcd/releases/download
DOWNLOAD_URL=${GITHUB_URL}

rm -f /tmp/etcd-{{ ETCD_VER }}-linux-{{ Arch }}.tar.gz
rm -rf /tmp/etcd-download-test && mkdir -p /tmp/etcd-download-test

curl -L ${DOWNLOAD_URL}/{{ ETCD_VER }}/etcd-{{ ETCD_VER }}-linux-{{ Arch }}.tar.gz -o /tmp/etcd-{{ ETCD_VER }}-linux-{{ Arch }}.tar.gz
tar xzvf /tmp/etcd-{{ ETCD_VER }}-linux-{{ Arch }}.tar.gz -C /tmp/etcd-download-test --strip-components=1

cp /tmp/etcd-download-test/etcd* /usr/local/bin/


