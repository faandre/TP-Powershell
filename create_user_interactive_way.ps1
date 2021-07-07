#Request user name and first name
$name = Read-Host "Name and first name of the user to be created"

#Request user login
$login = Read-Host "login of the user to be created"

#Request user password
$pwd = Read-Host "Password of the user to be created"

#Create user
New-ADUser -Name $name -SamAccountName $login -UserPrincipalName $login@lavachette.com -AccountPassword (ConvertTo-SecureString -AsPlainText $pwd -Force) -PasswordNeverExpires $true -CannotChangePassword $true -Enabled $true

# run the script by doing powershell .\create_user_interactive_way.ps1
# display created users Get-ADUser -Filter * | select samAccountName 
#get more information Get-ADUser -Filter * | select Name, samAccountName, UserPrincipalName
# open the created csv file Notepad.exe UserAdUTF8.csv