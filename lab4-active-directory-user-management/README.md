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
![OU_“Company”_Created](./screenshots/"7.1 — OU “Company” created under lab.local.png")

---

### 7.2 — Create Departmental OUs
Added departmental sub-OUs under “Company”: **IT**, **HR**, **Sales**, and **Finance**.  
![OU Hierarchy Visible](./screenshots/"7.2 — OU hierarchy visible under “Company”.png")

---

### 7.3 — Create IT Security Group
Created a security group for IT department users.  
![IT_Users Group](./screenshots/"7.4a_IT_Users.png")

---

### 7.4 — Create HR Security Group
Configured a dedicated HR security group for HR staff access.  
![HR_Users Group](./screenshots/"7.4b_HR_Users.png.png")

---

### 7.5 — Create Sales Security Group
Configured the **Sales_Users** group for departmental isolation.  
![Sales_Users Group](./screenshots/"7.4c_Sales_Users.png.png")

---

### 7.6 — Create Finance Security Group
Configured the **Finance_Users** group for financial data access policies.  
![Finance_Users Group](./screenshots/"7.4d_Finance_Users.png.png")

---

### 7.7 — Configure Domain Password Policy
Defined global domain password rules for length, age, and complexity.  
![Password Policy Config](./screenshots/"7.7 – Domain Password Policy Configuration.png")

---

### 7.8 — Configure Domain Account Lockout Policy
Set thresholds for failed logins and reset timing to improve security.  
![Lockout Policy Config](./screenshots/"7.8 – Domain Account Lockout Policy Configuration.png")

---

### 7.9 — Verify Department Group Membership
Confirmed **Emily Perez** and **John Smith** belong to `HR_Users` group.  
![Group Membership Verification](./screenshots/"7.9 – Department Group Membership Verification.png")

---

### 7.10 — Link HR GPO to OU
Linked a new **HR Desktop Policy** GPO to the HR OU for restricted settings.  
![GPO Linked to HR OU](./screenshots/"7.10 – Department-Specific GPO Linked to OU (HR Example).png")

---

### 7.11 — Configure Desktop Restriction Policy
Inside the HR Desktop Policy, configured “Disable all items” under Desktop restrictions.  
![Desktop Restriction Configured](./screenshots/"Desktop Restriction Policy Configured for HR OU.png")

---

### 7.12 — Verify HR Desktop Policy Application
Logged in as **LAB\Emily.Perez** and verified GPO application using `gpresult /r`.  
![HR Desktop Policy Applied](./screenshots/"HR Desktop Policy Applied to HR User”.png")

---

### 7.13 — Create IT Security Groups
Created IT administrative and user groups for future RBAC testing.  
![IT Security Groups Created](./screenshots/"IT securitygroups created.png")

---

### 7.14 — Assign HR Role-Based Access (RBAC)
Assigned appropriate HR permissions to users via RBAC model.  
![RBAC Assignment HR](./screenshots/"RbacassignmentHR.png")

---

### 7.15 — Create Example User
Created a new AD user (Sarah Lopez) with department assignment and login permissions.  
![New User Summary](./screenshots/"New User summary window with Sarah Lopez created.png")

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
