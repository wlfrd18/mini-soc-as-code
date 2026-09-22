# Configuration du profil PowerShell pour import automatique d'Atomic Red Team
# A executer sur chaque agent (adapter le chemin selon la plateforme)

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}
Add-Content -Path $PROFILE -Value 'Import-Module "$HOME/AtomicRedTeam/invoke-atomicredteam/Invoke-AtomicRedTeam.psd1" -Force'
