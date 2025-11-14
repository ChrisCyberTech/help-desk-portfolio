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
![01_Printer_Offline](Screenshots/01_Printer_Offline.png)

### 02 – Print Spooler service status
![02_Spooler_Service_Status](Screenshots/02_Spooler_Service_Status.png)

### 03 – Forced stop of Print Spooler
Commands used:
taskkill /F /IM spoolsv.exe
net stop spooler

yaml

![03_Stop_Spooler](Screenshots/03_Stop_Spooler.png)

### 04 – Cleared spool directory
Path:
C:\Windows\System32\spool\PRINTERS

yaml

![04_Clear_PrintQueue](Screenshots/04_Clear_PrintQueue.png)

### 05 – Restarted Print Spooler service
Command used:
net start spooler

css

![05_Start_Spooler](Screenshots/05_Start_Spooler.png)

### 06 – Reinstalled Microsoft Print to PDF
![06_Reinstall_Printer](Screenshots/06_Reinstall_Printer.png)

### 07 – Successful test print
![07_Test_Print](Screenshots/07_Test_Print.png)

## Summary
By clearing the print queue and restarting the Print Spooler service, I resolved a simulated “Printer Offline” issue. These steps replicate real-world help desk procedures used to fix printing problems quickly and effectively. The successful test print confirms that the printer and spooler were restored to full functionality.
