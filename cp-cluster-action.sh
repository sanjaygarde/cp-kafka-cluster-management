#!/bin/bash
#Pass the cp-ansible host inventory file as $1 and command as $2

if [ $# -ne 2 ]
  then
	echo "Arguments missing."
	echo "Usage: cp-cluster-action.sh <cp-ansible host inventory file> <command: start / stop / restart>"
    exit 1
fi

cp_ansible_inventory_file=$1
action=$2

if [ ! -e $cp_ansible_inventory_file ]
then
	echo "$cp_ansible_inventory_file does not exist."
	exit 1
fi

if ! [[ $action == "start" ||  $action == "stop"  || $action == "restart" ]]; then
	echo "Command should be start, stop or restart only."
	exit 1
fi

declare -a cp_components=(zookeeper kafka_broker schema_registry kafka_connect ksql kafka_rest control_center)

for a_component in "${cp_components[@]}"
do
	echo "Running $action for $a_component in the file $cp_ansible_inventory_file" 
	ansible -m shell -b -i $1 -a 'systemctl $action confluent*' $a_component
done 
