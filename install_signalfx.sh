#!/bin/bash

function setup_signalfx_in_running_containers(){
REMOTE_HOST=$1
echo $REMOTE_HOST
ssh $REMOTE_HOST <<'ENDSSH'
	user=$(whoami)
	if [ "$user" != "root" ]; then
		sudo su
	fi
	docker ps -aq | xargs -i docker exec {} bash -c "curl -sSL https://dl.signalfx.com/collectd-install | bash -s 'YOUR-SIGNALFX-TOKEN' -y"
	#docker ps -aq | xargs -i docker exec {} bash -c "collectd -h"
ENDSSH
}

setup_signalfx_in_running_containers ubuntu@masters1 &
setup_signalfx_in_running_containers ubuntu@masters2 &
#setup_signalfx_in_running_containers ubuntu@masters3 &

#(sync root@10.1.12.33 &&  ~/work/signalbox/collectd-integrations restart couchbase-server-4.1-0) & > /tmp/c1.status
#(sync root@10.1.8.152 && ~/work/signalbox/collectd-integrations restart couchbase-server-4.1-2) & > /tmp/c2.status