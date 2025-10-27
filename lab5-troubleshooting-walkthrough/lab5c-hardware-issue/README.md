# 🧰 Lab 5C – Hardware Troubleshooting

## Overview
This lab demonstrates a structured approach to **hardware-related issue diagnosis and resolution** using macOS command-line tools.  
The goal is to collect, analyze, and document system-level evidence to identify potential **disk, I/O, or memory performance issues**, then apply and verify fixes.

---

## 🗂️ Folder Structure  
lab5c-hardware-issue/  
└── case-01/  
├── CaseLog.md # Full case documentation  
├── Evidence/ # Collected logs and screenshots  
│ ├── collect-evidence.sh  
│ ├── systeminfo.txt  
│ ├── disk.txt  
│ ├── smart.txt  
│ ├── io.txt  
│ ├── memory.txt  
│ ├── peripherals.txt  
│ ├── disk-verify.png  
│ ├── smart-status.png  
│ └── io-performance.png  
└── Fixes/ # Automation scripts for remediation  
├── repair-disk.sh  
├── disable-spotlight.sh  
└── verify-health.sh  

yaml

---

## 🧩 Case Summary
### Case 01 – System Slow / Possible Disk or Hardware Failure
**Symptoms:**  
- Frequent spinning beachball, slow boot times, and Finder hangs  
- Console logs contain I/O errors  
- External USB drive disconnects intermittently  

**Root Cause:**  
Minor file-system corruption and heavy Spotlight indexing caused high I/O wait times.  

**Remediation:**  
1. Repaired disk structure using `diskutil repairVolume /`  
2. Verified SMART status and I/O performance  
3. Disabled Spotlight indexing on backup drive  
4. Confirmed system responsiveness restored  

**Verification Results:**  
- Disk and SMART checks passed successfully  
- I/O latency reduced to normal (<10ms)  
- No further performance issues detected after reboot  

---

## ⚙️ Key Tools and Commands
| Tool | Purpose |
|------|----------|
| `diskutil` | Disk verification and repair |
| `mdutil` | Manage Spotlight indexing |
| `iostat` | Monitor disk I/O performance |
| `vm_stat` | Check memory pressure |
| `system_profiler` | Gather hardware and peripheral data |

---

## ✅ Deliverables
- `CaseLog.md` – Detailed documentation of investigation and remediation  
- `Evidence/` – Collected command outputs and screenshots  
- `Fixes/` – Automated maintenance scripts for future reuse  

---

## 🧾 Reflection
This lab reinforced the value of **evidence-driven troubleshooting** and the importance of validating hardware health metrics before replacing components.  
By using repeatable scripts and structured documentation, hardware issues can be efficiently diagnosed, verified, and resolved with minimal downtime.

---

**Author:** Luis Chris Mejia  
*Date Completed: October 2025*  
**Repository:** [Help-Desk Portfolio](https://github.com/ChrisCyberTech/help-desk-portfolio)