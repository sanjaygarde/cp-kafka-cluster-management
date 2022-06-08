# cp-kafka-cluster-management
The scripts provided here allow you to execute simple tasks for a Confluent Platform cluster that was installed with cp-ansible (https://github.com/confluentinc/cp-ansible). You can start, stop, restart do a healtcheck for the cluster components.


E.g.
./cp-cluster-action.sh \<cp-ansible host inventory file\> \<start / stop / restart\>
  
./cp-cluster-action.sh \<cp-ansible host inventory file\>
