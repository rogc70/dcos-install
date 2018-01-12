#!/bin/bash
#
# SCRIPT:	get-dcos-public-agent-ip.sh
#
# DESCR:	Get the Amazon Public IP Address for the public DCOS agent node
#

# get the public IP of the public node if unset
cat <<EOF > /tmp/public-ip.json
{
  "id": "/public-ip",
  "cmd": "curl http://169.254.169.254/latest/meta-data/public-ipv4 && sleep 3600",
  "cpus": 0.25,
  "mem": 32,
  "instances": 1,
  "acceptedResourceRoles": [
    "slave_public"
  ]
}
EOF

echo
echo ' Starting public-ip.json marathon app'
echo
dcos marathon app add /tmp/public-ip.json

sleep 10

public_ip=`dcos task log --lines=1 public-ip`

echo
echo " The public node's public IP is: $public_ip "
echo " The HA Proxy console is http://$public_ip:9090/haproxy?stats "
echo

sleep 2

dcos marathon app remove public-ip

# end of script
