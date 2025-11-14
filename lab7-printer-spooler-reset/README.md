# Lab 7 – Printer Offline & Spooler Reset

## Overview
In this lab, I troubleshoot a common help desk issue where a printer appears **Offline** and print jobs become stuck in the queue. To resolve the problem, I forced the Print Spooler service to stop, cleared the spool directory, restarted the service, reinstalled the virtual printer (Microsoft Print to PDF), and successfully printed a test page.

## Tools Used
- Windows Settings (Printers & Scanners)
- Classic Devices and Printers
- Command Prompt (Administrator)
- Print Spooler service
- Windows Features
- File Explorer

## Steps and Evidence

### 01 – Printer shows “Offline”
![01_Printer_Offline](Evidence/01_Printer_Offline.png)

### 02 – Print Spooler service status
![02_Spooler_Service_Status](Evidence/02_Spooler_Service_Status.png)

### 03 – Forced stop of Print Spooler
Commands used:
taskkill /F /IM spoolsv.exe
net stop spooler

yaml
Copy code
![03_Stop_Spooler](Evidence/03_Stop_Spooler.png)

### 04 – Cleared spool directory
Path:
C:\Windows\System32\spool\PRINTERS

yaml
Copy code
![04_Clear_PrintQueue](Evidence/04_Clear_PrintQueue.png)

### 05 – Restarted Print Spooler service
Command used:
net start spooler

css
Copy code
![05_Start_Spooler](Evidence/05_Start_Spooler.png)

### 06 – Reinstalled Microsoft Print to PDF
![06_Reinstall_Printer](Evidence/06_Reinstall_Printer.png)

### 07 – Successful test print
![07_Test_Print](Evidence/07_Test_Print.png)

## Summary
By clearing the print queue and restarting the Print Spooler service, I resolved a simulated “Printer Offline” issue. These steps replicate real-world help desk procedures used to fix printing problems quickly and effectively. The successful test print confirms that the printer and spooler were restored to full functionality.
