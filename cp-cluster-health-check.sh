#!/bin/bash
#Pass the cp-ansible host inventory file as $1

if [ $# -ne 1 ]
  then
	echo "Arguments missing."
	echo "Usage: cp-cluster-health-check.sh <cp-ansible host inventory file> "
    exit 1
fi

cp_ansible_inventory_file=$1

if [ ! -e $cp_ansible_inventory_file ]
then
	echo "$cp_ansible_inventory_file does not exist."
	exit 1
fi


# TODO: Automate and parameterize the commands below

ansible -m shell -b -i $1 -a 'ps -ef | grep zoo' zookeeper
ansible -m shell -b -i $1 -a 'netstat -ln | grep 2181' zookeeper

ansible -m shell -b -i $1 -a 'ps -ef | grep kafka' kafka_broker
ansible -m shell -b -i $1 -a 'netstat -ln | grep 9091' kafka_broker
ansible -m shell -b -i $1 -a 'netstat -ln | grep 9092' kafka_broker
ansible -m shell -b -i $1 -a 'netstat -ln | grep 8091' kafka_broker

ansible -m shell -b -i $1 -a 'ps -ef | grep schema' schema_registry
ansible -m shell -b -i $1 -a 'netstat -ln | grep 8081' schema_registry

ansible -m shell -b -i $1 -a 'ps -ef | grep connect' kafka_connect 
ansible -m shell -b -i $1 -a 'netstat -ln | grep 8083' kafka_connect

ansible -m shell -b -i $1 -a 'ps -ef | grep ksql' ksql 
ansible -m shell -b -i $1 -a 'netstat -ln | grep 8088' ksql

ansible -m shell -b -i $1 -a 'ps -ef | grep kafka-rest' kafka_rest 
ansible -m shell -b -i $1 -a 'netstat -ln | grep 8082' kafka_rest

ansible -m shell -b -i $1 -a 'ps -ef | grep control' control_center
ansible -m shell -b -i $1 -a 'netstat -ln | grep 9021' control_center