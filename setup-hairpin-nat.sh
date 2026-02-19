#!/bin/bash
# Setup hairpin NAT for containerlab devices
# This allows local connections to 192.168.33.61:844X to reach the containerlab devices

echo "Setting up hairpin NAT rules for containerlab..."

# Add OUTPUT chain rules to redirect local traffic to 192.168.33.61
sudo iptables -t nat -C OUTPUT -d 192.168.33.61 -p tcp --dport 8441 -j DNAT --to-destination 172.16.2.11:443 2>/dev/null || \
  sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8441 -j DNAT --to-destination 172.16.2.11:443

sudo iptables -t nat -C OUTPUT -d 192.168.33.61 -p tcp --dport 8442 -j DNAT --to-destination 172.16.2.12:443 2>/dev/null || \
  sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8442 -j DNAT --to-destination 172.16.2.12:443

sudo iptables -t nat -C OUTPUT -d 192.168.33.61 -p tcp --dport 8443 -j DNAT --to-destination 172.16.2.101:443 2>/dev/null || \
  sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8443 -j DNAT --to-destination 172.16.2.101:443

sudo iptables -t nat -C OUTPUT -d 192.168.33.61 -p tcp --dport 8444 -j DNAT --to-destination 172.16.2.102:443 2>/dev/null || \
  sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8444 -j DNAT --to-destination 172.16.2.102:443

# Add POSTROUTING rule for return traffic
sudo iptables -t nat -C POSTROUTING -d 172.16.2.0/24 -p tcp --dport 443 -j MASQUERADE 2>/dev/null || \
  sudo iptables -t nat -A POSTROUTING -d 172.16.2.0/24 -p tcp --dport 443 -j MASQUERADE

echo "Hairpin NAT rules configured successfully!"
echo ""
echo "Testing connectivity..."
for port in 8441 8442 8443 8444; do
  result=$(curl -k -m 2 -s -u admin:admin https://192.168.33.61:$port/command-api \
    -d '{"jsonrpc":"2.0","method":"runCmds","params":{"version":1,"cmds":["show hostname"],"format":"json"},"id":"1"}' \
    -H "Content-Type: application/json" 2>/dev/null | jq -r '.result[0].hostname // "Failed"' 2>/dev/null)
  echo "Port $port: $result"
done

