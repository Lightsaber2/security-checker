# Windows Security Checker

A simple PowerShell script that checks basic Windows security settings.

## What it checks:
- ✅ Windows Defender status
- ✅ Windows Firewall status  
- ✅ Guest account status
- ✅ Antivirus definition updates
- ✅ UAC (User Account Control)

## How to use:
1. Download `security_check.ps1`
2. Open PowerShell as Administrator
3. Navigate to the file location: `cd C:\path\to\file`
4. Run: `.\security_check.ps1`
5. View your security status!

## Requirements:
- Windows 10/11
- PowerShell 5.1 or higher
- Administrator privileges

## Note:
This script only **reads** system settings - it doesn't make any changes to your PC.

## Sample Output:
```
====================================
Simple Security Checker
====================================
1. Checking Windows Defender...
   OK - Windows Defender is ON
2. Checking Windows Firewall...
   OK - Firewall is ON for all profiles
...
====================================
```

## License
MIT License