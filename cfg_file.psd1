@{
    RSGName_01 = "ESGI-YMF-DEV"
    Location = "westeurope"

    VM = @{
        Name_01 = "d-esgi-vm-iis-1"
        ImageName = "MicrosoftWindowsServer:WindowsServer:2016-Datacenter-Server-Core-smalldisk:latest"
        Size = "Standard_B1s"
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
        Name = "d-esgi-bastion"
        VnetName = "d-esgi-vnet-bastion"
        VnetAddressPrefix = "192.168.0.0/16"
        SubnetName = "AzureBastionSubnet"
        PublicIP_Name = "d-esgi-publicip-bastion"
        SubnetAddressPrefix = "192.168.2.0/27"
    }
}