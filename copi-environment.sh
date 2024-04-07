#!/bin/bash

echo "home="$1 >> $1/.bashrc

echo "127.0.0.1:3128 -> environment"
	echo "export http_proxy=\"http://127.0.0.1:3128\"" >> /etc/environment
	echo "export https_proxy=\"http://127.0.0.1:3128\"" >> /etc/environment

