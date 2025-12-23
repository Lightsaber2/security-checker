# Simple Security Checker
# This script ONLY READS settings - it doesn't change anything on your PC

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Simple Security Checker" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Check 1: Is Windows Defender running?
Write-Host "1. Checking Windows Defender..." -ForegroundColor Yellow
$defender = Get-MpComputerStatus
if ($defender.RealTimeProtectionEnabled) {
    Write-Host "   OK - Windows Defender is ON" -ForegroundColor Green
} else {
    Write-Host "   ERROR - Windows Defender is OFF - You should turn it on!" -ForegroundColor Red
}
Write-Host ""

# Check 2: Is Windows Firewall on?
Write-Host "2. Checking Windows Firewall..." -ForegroundColor Yellow
$firewall = Get-NetFirewallProfile -Profile Domain, Public, Private
$allEnabled = $true
foreach ($profile in $firewall) {
    if ($profile.Enabled -eq $false) {
        $allEnabled = $false
        Write-Host "   ERROR - Firewall is OFF for $($profile.Name)" -ForegroundColor Red
    }
}
if ($allEnabled) {
    Write-Host "   OK - Firewall is ON for all profiles" -ForegroundColor Green
}
Write-Host ""

# Check 3: Is the Guest account disabled?
Write-Host "3. Checking Guest Account..." -ForegroundColor Yellow
$guest = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue
if ($guest -and $guest.Enabled -eq $false) {
    Write-Host "   OK - Guest account is disabled (good!)" -ForegroundColor Green
} elseif ($guest -and $guest.Enabled -eq $true) {
    Write-Host "   ERROR - Guest account is enabled - Should be disabled" -ForegroundColor Red
} else {
    Write-Host "   INFO - Guest account not found" -ForegroundColor Gray
}
Write-Host ""

# Check 4: How old are your antivirus definitions?
Write-Host "4. Checking Antivirus Updates..." -ForegroundColor Yellow
$lastUpdate = $defender.AntivirusSignatureLastUpdated
$daysOld = (Get-Date) - $lastUpdate
if ($daysOld.Days -le 7) {
    Write-Host "   OK - Antivirus definitions are up to date ($($daysOld.Days) days old)" -ForegroundColor Green
} else {
    Write-Host "   ERROR - Antivirus definitions are old ($($daysOld.Days) days) - Run Windows Update" -ForegroundColor Red
}
Write-Host ""

# Check 5: Is UAC (User Account Control) enabled?
Write-Host "5. Checking UAC (User Account Control)..." -ForegroundColor Yellow
$uac = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System").EnableLUA
if ($uac -eq 1) {
    Write-Host "   OK - UAC is enabled" -ForegroundColor Green
} else {
    Write-Host "   ERROR - UAC is disabled - You should enable it!" -ForegroundColor Red
}
Write-Host ""

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Scan Complete!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to exit"