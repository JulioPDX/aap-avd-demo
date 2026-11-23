# s1-spine2

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [IP Name Servers](#ip-name-servers)
  - [Domain Lookup](#domain-lookup)
  - [NTP](#ntp)
- [Authentication](#authentication)
  - [Enable Password](#enable-password)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [EOS CLI Device Configuration](#eos-cli-device-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | Description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | OOB_MANAGEMENT | oob | default | 192.168.0.11/24 | - |

##### IPv6

| Management Interface | Description | Type | VRF | IPv6 Address | IPv6 Gateway | ND RA Disabled | ND RA RX Accept | ND Managed Config Flag | ND Other Config Flag | ND Cache | ND RA DNS Servers |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ | -------------- | --------------- | ---------------------- | -------------------- | -------- | ----------------- |
| Management0 | OOB_MANAGEMENT | oob | default | - | - | - | - | - | - | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management0
   description OOB_MANAGEMENT
   no shutdown
   ip address 192.168.0.11/24
```

### IP Name Servers

#### IP Name Servers Summary

| Name Server | VRF | Priority |
| ----------- | --- | -------- |
| 1.1.1.1 | default | - |

#### IP Name Servers Device Configuration

```eos
ip name-server vrf default 1.1.1.1
```

### Domain Lookup

#### DNS Domain Lookup Summary

| Source interface | vrf |
| ---------------- | --- |
| Management0 | - |

#### DNS Domain Lookup Device Configuration

```eos
ip domain lookup source-interface Management0
```

### NTP

#### NTP Summary

##### NTP Local Interface

| Interface | VRF |
| --------- | --- |
| Management0 | default |

##### NTP Servers

NTP servers VRF: default

| Server | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Source Address | Key |
| ------ | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | -------------- | --- |
| 0.pool.ntp.org | True | - | - | - | - | - | - | - | - |

#### NTP Device Configuration

```eos
!
ntp local-interface Management0
ntp server 0.pool.ntp.org prefer
```

## Authentication

### Enable Password

Enable password has been disabled

## Spanning Tree

### Spanning Tree Summary

STP mode: **none**

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode none
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ----------------- | --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |

*Inherited from Port-Channel Interface

##### IPv4

| Interface | Description | Channel Group | IP Address | VRF | MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | ------------- | ---------- | --- | --- | -------- | ------ | ------- |
| Ethernet2 | P2P_s1-leaf1_Ethernet3 | - | 10.255.255.2/31 | default | 9214 | False | - | - |
| Ethernet3 | P2P_s1-leaf2_Ethernet3 | - | 10.255.255.6/31 | default | 9214 | False | - | - |
| Ethernet4 | P2P_s1-leaf3_Ethernet3 | - | 10.255.255.10/31 | default | 9214 | False | - | - |
| Ethernet5 | P2P_s1-leaf4_Ethernet3 | - | 10.255.255.14/31 | default | 9214 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet2
   description P2P_s1-leaf1_Ethernet3
   no shutdown
   mtu 9214
   no switchport
   ip address 10.255.255.2/31
!
interface Ethernet3
   description P2P_s1-leaf2_Ethernet3
   no shutdown
   mtu 9214
   no switchport
   ip address 10.255.255.6/31
!
interface Ethernet4
   description P2P_s1-leaf3_Ethernet3
   no shutdown
   mtu 9214
   no switchport
   ip address 10.255.255.10/31
!
interface Ethernet5
   description P2P_s1-leaf4_Ethernet3
   no shutdown
   mtu 9214
   no switchport
   ip address 10.255.255.14/31
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | ROUTER_ID | default | 10.255.0.2/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Addresses |
| --------- | ----------- | --- | -------------- |
| Loopback0 | ROUTER_ID | default | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description ROUTER_ID
   no shutdown
   ip address 10.255.0.2/32
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |

#### IP Routing Device Configuration

```eos
!
ip routing
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| default | False |

### Router BGP

ASN Notation: asplain

#### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65100 | 10.255.0.2 |

| BGP Tuning |
| ---------- |
| update wait-install |
| no bgp default ipv4-unicast |
| maximum-paths 4 |

#### Router BGP Peer Groups

##### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Next-hop unchanged | True |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 3 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 256000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Maximum-accepted-routes | Maximum-advertised-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive | TTL Max Hops |
| -------- | --------- | --- | -------- | -------------- | -------------- | ----------------------- | ------------------------- | ---------- | --- | --------------------- | ---------------------- | ------- | ------------ |
| 10.255.0.3 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.0.4 | 65101 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.0.5 | 65102 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.0.6 | 65102 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - | - |
| 10.255.255.3 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - | - | - |
| 10.255.255.7 | 65101 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - | - | - |
| 10.255.255.11 | 65102 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - | - | - |
| 10.255.255.15 | 65102 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Route-map In | Route-map Out | Peer-tag In | Peer-tag Out | Encapsulation | Next-hop-self Source Interface |
| ---------- | -------- | ------------ | ------------- | ----------- | ------------ | ------------- | ------------------------------ |
| EVPN-OVERLAY-PEERS | True | - | - | - | - | default | - |

#### Router BGP Device Configuration

```eos
!
router bgp 65100
   router-id 10.255.0.2
   update wait-install
   no bgp default ipv4-unicast
   maximum-paths 4
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS next-hop-unchanged
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS password 7 <removed>
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 256000
   neighbor 10.255.0.3 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.0.3 remote-as 65101
   neighbor 10.255.0.3 description s1-leaf1_Loopback0
   neighbor 10.255.0.4 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.0.4 remote-as 65101
   neighbor 10.255.0.4 description s1-leaf2_Loopback0
   neighbor 10.255.0.5 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.0.5 remote-as 65102
   neighbor 10.255.0.5 description s1-leaf3_Loopback0
   neighbor 10.255.0.6 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.0.6 remote-as 65102
   neighbor 10.255.0.6 description s1-leaf4_Loopback0
   neighbor 10.255.255.3 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.255.3 remote-as 65101
   neighbor 10.255.255.3 description s1-leaf1_Ethernet3
   neighbor 10.255.255.7 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.255.7 remote-as 65101
   neighbor 10.255.255.7 description s1-leaf2_Ethernet3
   neighbor 10.255.255.11 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.255.11 remote-as 65102
   neighbor 10.255.255.11 description s1-leaf3_Ethernet3
   neighbor 10.255.255.15 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.255.15 remote-as 65102
   neighbor 10.255.255.15 description s1-leaf4_Ethernet3
   redistribute connected route-map RM-CONN-2-BGP
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
```

## BFD

### Router BFD

#### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 300 | 300 | 3 |

#### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 300 min-rx 300 multiplier 3
```

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.255.0.0/27 eq 32 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.255.0.0/27 eq 32
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |

### VRF Instances Device Configuration

```eos
```

## EOS CLI Device Configuration

```eos
!
username admin privilege 15 role network-admin secret 5 $1$5O85YVVn$HrXcfOivJEnISTMb6xrJc.
username arista privilege 15 role network-admin secret 5 $1$4VjIjfd1$XkUVulbNDESHFzcxDU.Tk1
username arista ssh-key ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0w+pDAIPjxt7GadeDTXWoZJfncqbYWA4gVdn68YD/HcEC6Jii7fX4B2P27AKuzhzCDOSht2f2nmm/rdlQZmPuysGbrSKsJR6eTcLOzbYuXtaVCcBgbB8Y8ur5GJrjaeIeurvOm75V0WqKsn1dYVMrtEbRcQcbgu42/AKyvuimJunWP1TfKSwrF99tUHXEWktQCoKwn5pIc1gPE3F+U73MrGQsqe2/jvH7XR0C9qpjrMQNqj/jCO+lefjLHMe497jUT5aBSLyBrVSyBcqymtJ2LTLnO48vSuw+mHIqQZIaA0P0GO4yDNkWe/lsSs5TH137XAE3pVdhnvL6WLvqHUHZ arista@aap-avd-1-d555df96-eos
!
management api http-commands
  no shutdown
!
daemon TerminAttr
  exec /usr/bin/TerminAttr -cvcompression=gzip -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata -ingestexclude=/Sysdb/cell/1/agent,/Sysdb/cell/2/agent -cvaddr=192.168.0.5:9910 -cvauth=token,/tmp/token -cvvrf=default -taillogs -disableaaa
  no shutdown
!

```
