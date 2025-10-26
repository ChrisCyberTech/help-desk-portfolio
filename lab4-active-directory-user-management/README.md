# 🧩 Helpdesk Lab 4 — Active Directory User Management

**Objective:**  
This lab demonstrates the process of configuring **Active Directory (AD)** for user and group management within a simulated enterprise environment.  
The focus is on organizational structure, role-based security groups, password and lockout policies, and targeted Group Policy Objects (GPOs) for department-level administration.

---

## 🧠 Key Skills Demonstrated
- Active Directory Domain Services (AD DS) configuration
- Organizational Unit (OU) and group hierarchy design
- Group Policy Object (GPO) creation and linking
- Account security enforcement (password & lockout policies)
- Role-Based Access Control (RBAC)
- Desktop policy deployment for department-level restrictions
- Verifying applied GPOs using `gpresult`

---

## 🖥️ Environment Setup
- **Platform:** Windows Server 2025 (Datacenter Evaluation)  
- **Domain Controller:** `DC01.lab.local`  
- **Domain Name:** `lab.local`  
- **Administrative User:** `LAB\Administrator`  
- **Example Standard User:** `LAB\Emily.Perez` (HR Department)

---

## 🧱 Step-by-Step Lab Walkthrough

### 7.1 — Create Company Organizational Unit
Created a top-level **OU named “Company”** under `lab.local` to hold all departments.  
![7.1 OU Company Created](./screenshots/7.1%20–%20OU%20"Company"%20created%20under%20lab.local.png)

---

### 7.2 — Create Departmental OUs
Added departmental sub-OUs under “Company”: **IT**, **HR**, **Sales**, and **Finance**.  
![7.2 Department OUs Created](./screenshots/7.2%20-%20Department%20OUs%20created%20under%20Company.png)

---

### 7.3 — Create IT Users Group
Created a security group for IT department users.  
![7.3 IT Users Group Created](./screenshots/7.3%20IT%20Users%20group%20created.png)

---

### 7.4 — Create HR Users Group
Configured a dedicated HR security group for HR staff access.  
![7.4 HR Users Group Created](./screenshots/7.4%20–%20HR_Users%20group%20created.png)

---

### 7.5 — Create Sales Users Group
Configured the **Sales_Users** group for departmental isolation.  
![7.5 Sales Users Group Created](./screenshots/7.5%20–%20Sales_Users%20group%20created.png)

---

### 7.6 — Create Finance Users Group
Configured the **Finance_Users** group for financial data access policies.  
![7.6 Finance Users Group Created](./screenshots/7.6%20–%20Finance_Users%20group%20created.png)

---

### 7.7 — Configure Domain Password Policy
Defined global domain password rules for length, age, and complexity.  
![7.7 Domain Password Policy Configuration](./screenshots/7.7%20–%20Domain%20Password%20Policy%20Configuration.png)

---

### 7.8 — Configure Domain Account Lockout Policy
Set thresholds for failed logins and reset timing to improve security.  
![7.8 Domain Account Lockout Policy Configuration](./screenshots/7.8%20–%20Domain%20Account%20Lockout%20Policy%20Configuration.png)

---

### 7.9 — Verify Group Membership
Confirmed **Emily Perez** and **John Smith** belong to `HR_Users` group.  
![7.9 Group Membership Verified for HR Users](./screenshots/7.9%20–%20Group%20Membership%20Verified%20for%20HR%20Users.png)

---

### 7.10 — Link HR GPO to OU
Linked a new **HR Desktop Policy** GPO to the HR OU for restricted settings.  
![7.10 HR GPO Linked to OU](./screenshots/7.10%20–%20HR%20GPO%20Linked%20to%20OU.png)

---

### 7.11 — Configure Desktop Restriction Policy
Inside the HR Desktop Policy, configured “Disable all items” under Desktop restrictions.  
![7.11 Desktop Restriction Policy Configured](./screenshots/7.11%20–%20Desktop%20Restriction%20Policy%20Configured%20for%20HR%20OU.png)

---

### 7.12 — Verify HR Desktop Policy Application
Logged in as **LAB\Emily.Perez** and verified GPO application using `gpresult /r`.  
![7.12 HR Desktop Policy Applied](./screenshots/7.12%20–%20HR%20Desktop%20Policy%20Applied%20to%20HR%20User.png)

---

### 7.13 — Create IT Security Groups
Created IT administrative and user groups for future RBAC testing.  
![7.13 IT Security Groups Created](./screenshots/7.13%20–%20IT%20Security%20Groups%20Created.png)

---

### 7.14 — Assign HR Role-Based Access
Assigned appropriate HR permissions to users via RBAC model.  
![7.14 HR Role-Based Access Assignment](./screenshots/7.14%20–%20HR%20Role-Based%20Access%20Assignment.png)

---

### 7.15 — Create Example User (Sarah Lopez)
Created a new AD user (Sarah Lopez) with department assignment and login permissions.  
![7.15 New User Summary](./screenshots/7.15%20–%20New%20User%20Summary%20(Sarah%20Lopez%20Created).png)

---

## 🔍 Validation
Verified via `gpresult` and **Group Policy Management Console (GPMC)** that:
- HR users inherited the **HR Desktop Policy**.
- Password and lockout policies applied globally.
- Each department OU and group mapped correctly to users.

---

## 🧾 Outcome
✅ Successfully demonstrated:
- End-to-end AD organizational structure setup  
- Secure password & lockout enforcement  
- Department-specific policy deployment  
- Verification of GPO propagation and RBAC configuration  

This lab highlights **real-world Active Directory administration**, a core helpdesk and systems support skillset.

---

## 📂 Folder Structure Example
