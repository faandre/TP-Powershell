@{
    RSGName_01 = "ESGI-YMF-DEV"
    Location = "westeurope"

    VM = @{
        Name_01 = "d-esgi-vm-iis-1"
        ImageName = "MicrosoftWindowsServer:WindowsServer:2016-Datacenter-Server-Core-smalldisk:latest"
        Size = "Standard_B1s"
        Extensions_IIS = "Yes"
    }

    Network = @{
        VnetName = "d-esgi-vnet1"
        VnetAddressPrefix = "10.0.0.0/16"
        SubnetName_01 = "d-esgi-subnet-01"
        SubnetAddressPrefix = "10.0.1.0/24"
        NSGName_01 = "d-esgi-nsg-web-01"
        PublicIP_Name = "d-esgi-publicip-01"
    }
    
    Bastion = @{
        VnetName = "d-esgi-vnet-bastion"
        VnetAddressPrefix = "192.168.0.0/16"
        SubnetName = "AzureBastionSubnet"
        PublicIP_Name = "d-esgi-publicip-bastion"
        SubnetAddressPrefix = "192.168.2.0/27"
    }

    Data = @{
        VM_file_Name = "C:\Powershell\Projet\ESGI_YMF_Virtual_Machines.csv"
    }
}

<#$subnetName = "AzureBastionSubnet"
$subnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix 10.0.0.0/24
$vnet = New-AzVirtualNetwork -Name "myVnet" -ResourceGroupName "myBastionRG" -Location "westeurope" -AddressPrefix 10.0.0.0/16 -Subnet $subnet


#VM_Extension = @{
#    Settings = "'{"commandToExecute":"powershell Add-WindowsFeature Web-Server"}'"
#}

#>