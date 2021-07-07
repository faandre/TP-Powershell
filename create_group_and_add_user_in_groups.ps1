#Request group name
$group = Read-Host "name of the group to be created"
#Create group
New-ADGroup $group -GroupScope Global

#Request number of user
[int] $number = Read-Host "Number of Users to be Inserted into the Group"

#insert users in group
for ($i=1; $i -le $number; $i++)
{

    $name = Read-Host "Please Enter the User Name to Insert in the Group $group"
    Add-ADGroupMember -identity $group -Members $name
    Write-Host "User $name Has Been Inserted into the Group $group."

}

#display groups list Get-ADGroup -Filter *
#lists of users in the group Get-ADGroupMember nomdugroupe
#Get-ADGroupMember groupname | Export-Csv filename.csv -Encoding UTF8  to display group info in csv file