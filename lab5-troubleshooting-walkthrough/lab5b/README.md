# Lab 5B – Software Troubleshooting

This lab demonstrates tier-1 and tier-2 help-desk troubleshooting across common software issues.  
Each case documents a real-world scenario with evidence collection, analysis, remediation, and verification.

---

## 📂 Folder Structure

lab5b/
├── case-01/ → Chrome slow or hangs (CPU/RAM/Disk)
├── case-02/ → App won’t launch (Crash / Permissions)
└── case-03/ → App can’t connect (DNS / Proxy / TLS)

markdown
Copy code

Each case folder includes:
- **CaseLog.md** – documentation of the issue, evidence, analysis, and fixes  
- **Evidence/** – shell scripts and text outputs collected for analysis  
- **Fixes/** – remediation or simulation scripts to resolve or verify the issue  

---

## 🧩 Case Summaries

### Case-01 – Chrome Slow or Hangs
- **Focus:** Performance troubleshooting  
- **Symptoms:** High CPU/RAM usage, tabs freezing  
- **Techniques:** Process inspection, disk checks, log review  
- **Outcome:** Identified excessive extensions and high cache usage; restored performance after cleanup  

### Case-02 – App Won’t Launch (Instant Crash)
- **Focus:** Launch failure and crash diagnosis  
- **Symptoms:** App quits immediately on launch, no GUI output  
- **Techniques:** Crash log analysis, permissions and Gatekeeper quarantine removal, preference reset  
- **Outcome:** App successfully launched after permissions and quarantine fixes  

### Case-03 – App Can’t Connect to Network
- **Focus:** Connectivity and TLS troubleshooting  
- **Symptoms:** “Unable to reach server” error  
- **Techniques:** DNS and proxy inspection, TLS handshake verification, DNS flush, proxy reset  
- **Outcome:** Restored network connectivity after clearing stale proxy settings  

---

## 🧠 Skills Demonstrated
- System log analysis (`log show`, `Console.app`, `DiagnosticReports`)  
- Evidence collection using custom Bash scripts  
- Process and performance troubleshooting  
- macOS permissions, ownership, and quarantine handling  
- Network/DNS/TLS troubleshooting  
- Clear technical documentation and change verification  

---

## ✅ Deliverables
- Three complete troubleshooting cases with supporting evidence  
- Verified scripts and Markdown documentation for each scenario  
- Demonstrated understanding of tiered software support processes  

---

**Author:** Luis Mejia  
**Course:** UCLA Extension – Fundamentals of Cybersecurity  
**Lab:** 5B – Software Troubleshooting