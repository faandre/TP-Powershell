#Prérequis 
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord


#Installation de l'AD
Install-Module AzureADpreview
Import-Module AzureADpreview
$cred = Get-Credential
Connect-AzureAD -Credential $cred

#Uninstall
#Uninstall-Module AzureADpreview
#Import-Module ADDSDeployement

#Configuration DNS
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

#On configure la forêt avec cette commande
Install-ADDSForest

#Pour résoudre les addresses via notre serveur DNS
Get-DnsServerForwarder
#Si je veux changer la redirection du DNS
Add-DnsServerFowarder -IPAddress 8.8.8.8

