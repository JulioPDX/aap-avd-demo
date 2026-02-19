# Hairpin NAT Setup for Containerlab

## Problem

When running containerlab on a machine with IP `192.168.33.61`, Docker publishes ports to `0.0.0.0`, which makes them accessible from remote machines. However, **local processes cannot connect to `192.168.33.61:844X`** due to a networking limitation called "hairpin NAT" or "NAT loopback".

The issue occurs because:

1. The local machine routes `192.168.33.61` through the loopback interface (`lo`)
2. Docker's NAT rules in the PREROUTING chain don't apply to locally-originated traffic
3. Connections from the local machine to `192.168.33.61:844X` timeout

## Solution

We need to add iptables rules to handle local connections to `192.168.33.61`:

1. **OUTPUT chain rules**: Redirect local traffic destined for `192.168.33.61:844X` to the containerlab network
2. **POSTROUTING rule**: Masquerade return traffic so containers can respond

## Setup

### Automatic Setup

Run the provided script after deploying containerlab:

```bash
./setup-hairpin-nat.sh
```

### Manual Setup

If you prefer to set up manually:

```bash
# Redirect local traffic to containerlab devices
sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8441 -j DNAT --to-destination 172.16.2.11:443
sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8442 -j DNAT --to-destination 172.16.2.12:443
sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8443 -j DNAT --to-destination 172.16.2.101:443
sudo iptables -t nat -A OUTPUT -d 192.168.33.61 -p tcp --dport 8444 -j DNAT --to-destination 172.16.2.102:443

# Masquerade return traffic
sudo iptables -t nat -A POSTROUTING -d 172.16.2.0/24 -p tcp --dport 443 -j MASQUERADE
```

## Verification

Test connectivity to all devices:

```bash
# Test with curl
for port in 8441 8442 8443 8444; do
  curl -k -s -u admin:admin https://192.168.33.61:$port/command-api \
    -d '{"jsonrpc":"2.0","method":"runCmds","params":{"version":1,"cmds":["show hostname"],"format":"json"},"id":"1"}' \
    -H "Content-Type: application/json" | jq -r '.result[0].hostname'
done

# Test with Ansible
ansible FABRIC -m arista.eos.eos_command -a "commands='show hostname'" --forks=1
```

## Port Mapping

- `192.168.33.61:8441` → htft-spine1 (172.16.2.11:443)
- `192.168.33.61:8442` → htft-spine2 (172.16.2.12:443)
- `192.168.33.61:8443` → htft-leaf1a (172.16.2.101:443)
- `192.168.33.61:8444` → htft-leaf1b (172.16.2.102:443)

## Persistence

**Note**: These iptables rules are **not persistent** across reboots. You need to run `./setup-hairpin-nat.sh` after each reboot or containerlab deployment.

To make them persistent, you can:

1. **Use iptables-persistent** (Debian/Ubuntu):

   ```bash
   sudo apt install iptables-persistent
   sudo netfilter-persistent save
   ```

2. **Add to containerlab post-deploy hook**: Create a script that runs after `containerlab deploy`

3. **Add to systemd service**: Create a service that runs on boot

## Remote Access

Remote machines can connect directly to `192.168.33.61:844X` without any special configuration. The hairpin NAT rules only affect **local** connections from the same machine.
