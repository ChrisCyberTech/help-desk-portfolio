# Case 02 – Application Won’t Launch (Instant Crash)

## 1) Environment
- **OS:** macOS (captured via `systeminfo.txt`)
- **Application:** ExampleApp
- **Version:** not available
- **User Type:** Standard User
- **Recent Changes:** App update or OS security patch prior to failure.

---

## 2) Symptoms
- User double-clicks the app icon — it flashes briefly, then closes.
- No visible error message.
- App process appears momentarily in Activity Monitor, then disappears.
- Reinstallation did not resolve the issue.
- No other apps appear affected.

---

## 3) Evidence (Collected)
Evidence collected with `collect-evidence.sh` on **2025-10-27 13:15**  

Files generated:
- `systeminfo.txt` → confirms OS and hardware.  
- `processes.txt` → shows process starts then dies.  
- `logs.txt` → includes crash traces or permission errors.  
- `permissions.txt` → shows ownership and read/execute access on the app bundle.  

Additional evidence:
- Crash logs pulled via `pull-crash-reports.sh` → archived in `Evidence/CrashReports/`.

**Key Findings:**
- DiagnosticReports show repeated crash logs referencing `EXC_BAD_ACCESS` (memory or permission issue).  
- App bundle owned by `root:wheel`, not user.  
- `xattr` indicates `com.apple.quarantine` flag present.  
- No disk or system resource issues detected.

---

## 4) Analysis
**Likely Root Causes:**
1. Corrupted preference or config files under `~/Library/Preferences`.  
2. macOS Gatekeeper quarantine flag preventing execution.  
3. Incorrect ownership or permission on the app bundle.  
4. Outdated code signature after update.

---

## 5) Remediation Steps
1. Checked system and crash logs:
   ```bash
   log show --predicate 'eventMessage CONTAINS[c] "ExampleApp"' --last 2h
   open ~/Library/Logs/DiagnosticReports/
2. Removed quarantine attribute:

- xattr -dr com.apple.quarantine "/Applications/ExampleApp.app"


3. Repaired app ownership and permissions:

- sudo chown -R $(whoami):staff "/Applications/ExampleApp.app"
sudo chmod -R a+rX "/Applications/ExampleApp.app"


4. Cleared corrupted preference file:

- rm -f ~/Library/Preferences/com.vendor.ExampleApp.plist


5. Relaunched the app from Terminal to verify startup output:

- /Applications/ExampleApp.app/Contents/MacOS/ExampleApp

---

Script Simulations (Fixes Folder)

The following scripts represent automated versions of the manual troubleshooting steps above:

- [x]reset-permissions.sh — repairs ownership and removes macOS quarantine attributes that can prevent execution.
Expected Result: App now allowed to launch by Gatekeeper.

- [x]clear-preferences.sh — deletes potentially corrupted preference files and cache directories.
Expected Result: Clean configuration; app no longer crashes on startup.

- [x]verify-launch.sh — attempts to launch the app and checks process persistence and related logs.
Expected Result: App process remains active; no new crash logs generated.

- [x]Verification Metric	Before Fix	After Fix	Notes
Launch Success	Failed	Successful	App window opens normally
Crash Logs	Present	None	DiagnosticReports empty
Ownership	root:wheel	user:staff	Permission corrected
Gatekeeper	Blocked	Verified	Quarantine removed

---

6) Verification

- After applying permission and preference resets, the application launched successfully.
verify-launch.sh confirmed a persistent process, no new crash reports, and normal CPU/memory activity.

---

7) Root Cause

- macOS Gatekeeper quarantine attribute and corrupted user preference file prevented the application from executing normally.

---

8) Preventive Measures

- Always move newly downloaded apps to /Applications before first launch.

- Run applications under user ownership, not root.

- Regularly clear old or corrupted preferences in ~/Library/Preferences.

- Install software updates directly from verified vendors or the App Store.

- Keep a backup of working configuration files to restore quickly if future corruption occurs.