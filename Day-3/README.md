# Network Analysis Report (Linux / WSL)

> **Report Type**: Network Analysis based on Controlled Failure Simulation
> **Environment**: Linux on Windows Subsystem for Linux (WSL)
> **Confidentiality**: All hostnames, IPs, and identifiers are generalized

---

## 1. Scope of Analysis

This report documents the **analysis of network behavior** during a controlled network failure and recovery exercise. The goal was not to document commands, but to **observe, analyze, and validate how the Linux network stack behaves** when connectivity is interrupted and restored.

---

## 2. Initial Network State (Baseline)

* Network interface was operational (UP and LOWER_UP)
* Valid IPv4 address assigned
* Default routing available
* External connectivity confirmed
* DNS resolution functioning correctly

**Inference**: System was in a healthy and fully connected network state.

---

## 3. Failure Injection

### Action

The primary network interface was administratively disabled to simulate a network outage.

### Observed Impact

* Immediate loss of external connectivity
* ICMP traffic returned *Network is unreachable*
* Interface state transitioned to DOWN

**Inference**: Network failure was successfully simulated at the interface level.

---

## 4. Post-Failure State Analysis

After re-enabling the interface:

* Interface returned to UP state
* IP address was reassigned
* External connectivity was **not restored**

Routing table analysis showed:

* Presence of local subnet route
* **Absence of default gateway**

**Root Cause Identified**: Missing default route prevented traffic from leaving the local network.

---

## 5. DNS Behavior Observation

* DNS queries using a public resolver succeeded
* DNS resolution via system resolver also succeeded

**Inference**: DNS was functional and not a contributing factor to connectivity failure.

---

## 6. Recovery Analysis

Due to WSL-managed networking:

* Traditional Linux DHCP recovery was not immediately available
* Network restoration required a full WSL network reinitialization

After reinitialization:

* Default gateway was restored automatically
* External connectivity resumed

**Inference**: In WSL environments, host-level network reset is the correct recovery mechanism.

---

## 7. Key Findings

* Interface state alone does not guarantee connectivity
* IP assignment without a default route results in total internet failure
* DNS availability does not imply network reachability
* WSL networking must be recovered via host-managed reset

---

## 8. Conclusion

This analysis confirms that controlled interface-level failures can lead to partial network recovery states where interfaces and IPs appear healthy, but routing is incomplete. The exercise demonstrates real-world troubleshooting scenarios and highlights the importance of routing validation during network incident analysis.

---

## 9. Evidence & Supporting Observations

The following commands were executed **only as evidence collection tools** during analysis. They are listed with **observed outcomes**, not as tutorials.

### Interface & Address State

```bash
ip a
```

**Observed:**

* Loopback interface active
* Primary interface UP
* IPv4 address assigned
* IPv6 link-local address present

---

### Active Interface Verification

```bash
ip addr show up
```

**Observed:**

* Only loopback and primary interface were active

---

### Connectivity Test (Before Failure)

```bash
ping -c 4 8.8.8.8
```

**Observed:**

* ICMP replies received
* No packet loss

---

### Path Analysis

```bash
traceroute google.com
```

**Observed:**

* Multiple network hops visible
* Successful reachability to destination

---

### Failure Injection

```bash
sudo ip link set eth0 down
```

**Observed:**

* Interface state changed to DOWN
* Immediate loss of connectivity

---

### Failure Confirmation

```bash
ping 8.8.8.8
```

**Observed:**

* Error: Network is unreachable

---

### Interface Restoration Attempt

```bash
sudo ip link set eth0 up
```

**Observed:**

* Interface returned to UP state
* Connectivity not restored

---

### Routing State Inspection

```bash
ip route
```

**Observed:**

* Local subnet route present
* Default gateway missing

---

### DNS Resolution Validation

```bash
nslookup google.com
nslookup google.com 8.8.8.8
```

**Observed:**

* Successful name resolution
* Confirms DNS was operational

---

### Port & Service Inspection

```bash
ss -tuln
```

**Observed:**

* DNS-related ports listening
* No abnormal port behavior

---

## 10. Final Assessment

The collected outputs support the analysis that the network failure was caused by an interface-level disruption followed by an incomplete routing recovery. DNS and interface state were healthy, but the absence of a default route prevented external connectivity. Recovery in a WSL environment required host-managed network reinitialization.

---

**End of Network Analysis Report**
