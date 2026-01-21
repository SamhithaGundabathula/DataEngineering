# Terraform Installation on Windows

This guide explains how to install Terraform on Windows using two methods.

**Method 1 (Chocolatey)** is recommended because it is easier and keeps Terraform updated automatically.

---

## What is Terraform?

Terraform is an Infrastructure-as-Code (IaC) tool used to provision and manage cloud infrastructure such as:
- Virtual Machines
- Storage buckets
- Databases
- Networks

Installing Terraform **does NOT create any cloud resources**.  
It only installs a command-line tool on your system.

---

## Prerequisites
- Windows 10 or Windows 11 (64-bit)
- PowerShell
- Internet connection
- Administrator access

---

## Method 1 (Recommended): Install Terraform using Chocolatey

### Step 1: Open PowerShell as Administrator
1. Press the **Windows key**
2. Search for **PowerShell**
3. Right-click → **Run as Administrator**

---

### Step 2: Check if Chocolatey is installed
Run:
```powershell
choco --version
```
If a version number appears → Chocolatey is already installed  

If not, continue to Step 3  

---

## Step 3: Install Chocolatey

Run the following command **once**:

```powershell

Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

```

### After Installation
- Close PowerShell  
- Reopen PowerShell **as Administrator**

---

## Step 4: Install Terraform
Run:
```powershell
choco install terraform -y
```

## Step 5: Verify Installation
Run:
```powershell
terraform -version
Expected output:
```
text
Copy code
Terraform v1.x.x
If you see a version number, Terraform is installed successfully.

# Method 2: Manual Installation (ZIP + PATH)
## Step 1: Download Terraform
Go to the official Terraform website (by HashiCorp)

Download Windows → AMD64 (64-bit) ZIP file

## Step 2: Extract Terraform
Unzip the downloaded file

You will see terraform.exe

## Step 3: Create a Folder for Terraform
Create a folder:

text
Copy code
C:\terraform
Move terraform.exe into this folder.

## Step 4: Add Terraform to PATH
Open Control Panel

Go to System → Advanced system settings

Click Environment Variables

Under System variables, select Path → Edit

Click New and add:

text
Copy code
C:\terraform
Click OK and close all windows