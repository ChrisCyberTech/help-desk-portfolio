# Lab 9 – VPN Troubleshooting

**Objective:**  
Diagnose and repair VPN connection issues involving credentials, DNS failures, blocked ports, and certificate trust problems.  
This lab simulates real Help Desk VPN troubleshooting steps using Windows networking tools, PowerShell, Event Viewer, and certificate management.

---

## Ticket Scenario

**User:** Michael T.  
**Department:** Accounting  

**Issue Reported:**  
“I can’t connect to the VPN. It keeps failing no matter what I try.”

**Symptoms:**  
- VPN immediately disconnects  
- DNS lookups failing  
- Event Viewer shows RasClient errors  
- Possible port or firewall blocking  
- Certificate trust errors when using IKEv2  

**Environment Notes:**  
The workstation is a domain-joined Windows 11 client.  
The VPN server is simulated using a fake IP and a self-signed certificate.

---

# Scenario 1 – Credential Failure

**Explanation:**  
The user attempts to connect but fails due to either incorrect credentials or unresolved hostnames. The first step is to verify the VPN profile and confirm whether the client is attempting to reach the correct destination.

**VPN profile created**  
![Lab9-01_VPN_Profile_Created](./screenshots/Lab9-01_VPN_Profile_Created.png)

**VPN fails due to name resolution**  
The hostname cannot be resolved, preventing authentication from starting.  
![Lab9-02_VPN_Failed_Name_Resolution](./screenshots/Lab9-02_VPN_Failed_Name_Resolution.png)

**VPN fails even when using raw IP**  
This confirms the issue is not DNS-only and may involve authentication or network reachability.  
![Lab9-03_VPN_Tunnel_Failed_IP](./screenshots/Lab9-03_VPN_Tunnel_Failed_IP.png)

---

# Scenario 2 – DNS Failure

**Explanation:**  
DNS problems frequently break VPN connections. The user’s DNS was changed to a non-existent IP, causing hostname failures. Nslookup testing validates whether DNS is functional before retrying the VPN.

**Client DNS changed**  
![Lab9-04_Client_DNS_Changed](./screenshots/Lab9-04_Client_DNS_Changed.png)

**nslookup failure**  
The VPN hostname cannot resolve due to incorrect DNS configuration.  
![Lab9-05_NSLookup_Failure](./screenshots/Lab9-05_NSLookup_Failure.png)

**VPN fails due to DNS issue**  
Authentication cannot start because the hostname never resolves.  
![Lab9-06_VPN_Failure_DNS](./screenshots/Lab9-06_VPN_Failure_DNS.png)

**DNS restored**  
![Lab9-07_DNS_Restored](./screenshots/Lab9-07_DNS_Restored.png)

**nslookup successful after fix**  
![Lab9-08_NSLookup_After_Fix](./screenshots/Lab9-08_NSLookup_After_Fix.png)

---

# Scenario 3 – Port Blocking (443, 500, 4500)

**Explanation:**  
VPNs rely on specific ports depending on the protocol. For IKEv2/IPSec, ports 443, 500, and 4500 are critical. These tests simulate network firewalls blocking required ports.

**Outbound port 443 blocked**  
![Lab9-09_Block443_Rule](./screenshots/Lab9-09_Block443_Rule.png)

**Test-NetConnection shows 443 blocked**  
Confirms traffic cannot escape the workstation on that port.  
![Lab9-10_Test-Port443_Failed](./screenshots/Lab9-10_Test-Port443_Failed.png)

**VPN fails due to blocked 443**  
![Lab9-11_VPN_Failure_Port443](./screenshots/Lab9-11_VPN_Failure_Port443.png)

**Ports 500 and 4500 blocked**  
![Lab9-13_Test-Port500_4500_Failed](./screenshots/Lab9-13_Test-Port500_4500_Failed.png)

**VPN failure due to blocked IPsec ports**  
IKEv2 cannot negotiate key exchange.  
![Lab9-14_VPN_Failure_IPsecPorts](./screenshots/Lab9-14_VPN_Failure_IPsecPorts.png)

**Firewall rules removed**  
![Lab9-15_FirewallRules_Removed](./screenshots/Lab9-15_FirewallRules_Removed.png)

---

# Scenario 4 – Certificate Trust Failure (IKEv2)

**Explanation:**  
IKEv2 requires certificate trust. Without the correct certificate installed in the client Trusted Root store, authentication immediately fails. This scenario replicates that behavior.

**Self-signed VPN certificate created**  
![Lab9-16_SelfSignedCertCreated](./screenshots/Lab9-16_SelfSignedCertCreated.png)

**Certificate exported**  
![Lab9-17_ExportVPNCert](./screenshots/Lab9-17_ExportVPNCert.png)

**Certificate transferred to client**  
![Lab9-18_VPNCertOnClient](./screenshots/Lab9-18_VPNCertOnClient.png)

**DC01 Desktop Share**  
Used for certificate distribution  
![Lab9-18A_DC01_DesktopShared](./screenshots/Lab9-18A_DC01_DesktopShared.png)

**Client accessing the share**  
![Lab9-18B_Client_Accessing_Share](./screenshots/Lab9-18B_Client_Accessing_Share.png)

**Certificate installed into Trusted Root**  
Required for IKEv2 trust.  
![Lab9-19_InstalledTrustedRoot](./screenshots/Lab9-19_InstalledTrustedRoot.png)

**Initial no-cert VPN error**  
![Lab9-20_VPN_NoCertError](./screenshots/Lab9-20_VPN_NoCertError.png)

**IKEv2 settings applied**  
![Lab9-20A_IKEv2_Set](./screenshots/Lab9-20A_IKEv2_Set.png)

**Certificate error captured in Event Viewer (RasClient)**  
![Lab9-22_VPN_CertError_IKEv2](./screenshots/Lab9-22_VPN_CertError_IKEv2.png)

**Certificate trust restored successfully**  
![Lab9-23_TrustedRootRestored](./screenshots/Lab9-23_TrustedRootRestored.png)

**VPN error after certificate fix (non-certificate)**  
Shows that the cert trust issue is resolved.  
![Lab9-24_VPN_ErrorAfterCertFix](./screenshots/Lab9-24_VPN_ErrorAfterCertFix.png)

---

# Summary

This lab demonstrated troubleshooting for four major VPN problem categories:

1. **Credential failures** – Incorrect usernames, passwords, or unreachable authentication servers  
2. **DNS failures** – Misconfigured resolvers, hostname lookup issues  
3. **Port blocks** – Network firewalls blocking required ports (443, 500, 4500)  
4. **Certificate trust issues** – Missing or untrusted certificates for IKEv2 authentication  

Tools and skills practiced:

- Windows VPN client configuration  
- DNS management and nslookup testing  
- PowerShell network testing (Test-NetConnection)  
- Windows Firewall rule manipulation  
- Certificate Manager (certlm.msc)  
- Event Viewer (RasClient logs)  
- Understanding IKEv2/IPsec dependencies  

This workflow reflects real Help Desk and SysAdmin troubleshooting in corporate VPN environments.
