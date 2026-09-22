# Configuration de l'audit Windows pour le projet Mini-SOC as Code
# A executer sur l'agent Windows, en PowerShell administrateur

Write-Host "Activation de la politique d'audit de création de processus..."
auditpol /set /subcategory:"Creation du processus" /success:enable

Write-Host "Activation de l'inclusion de la ligne de commande complete..."
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -Type DWord

Write-Host "Verification de la politique appliquee..."
auditpol /get /subcategory:"Création du processus"

Write-Host "Configuration terminee. Redemarrage de l'agent Wazuh recommandé."
