# Case 01 – Google Chrome Slow or Hangs

## 1) Environment
- OS Build: (From `systeminfo` or `winver`)
- Application: Google Chrome (version number)
- Recent changes: Windows update KB____ installed, new extension added, or recent antivirus update.

## 2) Symptoms
- Chrome launches slowly (~30 seconds to open first window).
- Tabs become unresponsive (“Page Unresponsive” dialog).
- Task Manager shows Chrome.exe consuming high CPU and memory.
- Disk activity spikes during browser startup.
- Other apps run normally.

## 3) Evidence
### Commands and captures
Run these in **PowerShell (Admin)** and save outputs in `Evidence/`.

```powershell
# Create evidence folder
$E = "$PSScriptRoot\Evidence"; if (!(Test-Path $E)) { New-Item -ItemType Directory $E | Out-Null }

# System baseline
Get-ComputerInfo > "$E\computerinfo.txt"
systeminfo > "$E\systeminfo.txt"
Get-HotFix > "$E\hotfix.txt"

# Chrome process snapshot
Get-Process chrome | Sort CPU -Descending | Out-File "$E\chrome-processes.txt"

# Top resource consumers
Get-Process | Sort CPU -Descending | Select -First 20 | Out-File "$E\top-cpu.txt"
Get-Process | Sort PM -Descending  | Select -First 20 | Out-File "$E\top-memory.txt"

# Disk queue & usage
Get-WmiObject Win32_PerfFormattedData_PerfDisk_PhysicalDisk > "$E\disk-usage.txt"

# Network test
Test-NetConnection google.com -Port 443 > "$E\nettest.txt"
Resolve-DnsName google.com > "$E\dns.txt" 2>&1

# Event logs (recent Chrome or App errors)
$since = (Get-Date).AddHours(-2)
Get-WinEvent -FilterHashtable @{LogName='Application'; StartTime=$since} |
  Where-Object {$_.Message -match 'chrome' -or $_.Message -match 'hang' -or $_.Message -match 'crash'} |
  Export-Clixml "$E\application-chrome.evtx.xml"
