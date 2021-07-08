# Groupe 3 : Yoan, Morgan et Fabrice | Master1 : SRC

$script:ESGI_VMDeploy_version = "1.0.8"

$cfg_file = Import-LocalizedData -BaseDirectory "C:\Powershell\Projet\" -FileName "cfg_file.psd1" -ErrorAction Stop

Connect-AzAccount

# Create user object
$credentials = Get-Credential -Message "Enter a username and password for the virtual machine"

# Create a resource group
New-AzResourceGroup -Name $cfg_file.RSGName_01 -Location $cfg_file.Location

# Create a virtual network and subnet
$subnetcfg = New-AzVirtualNetworkSubnetConfig -Name $cfg_file.Network.SubnetName_01 -AddressPrefix $cfg_file.Network.SubnetAddressPrefix
New-AzVirtualNetwork -Name $cfg_file.Network.VnetName -ResourceGroupName $cfg_file.RSGName_01 -Location $cfg_file.Location -AddressPrefix $cfg_file.Network.VnetAddressPrefix -Subnet $subnetcfg

# Create a virtual machine
New-AzVM `
  -ResourceGroupName $cfg_file.RSGName_01 `
  -Name $cfg_file.VM.Name_01 `
  -Location $cfg_file.Location `
  -ImageName $cfg_file.VM.ImageName `
  -VirtualNetworkName $cfg_file.Network.VnetName `
  -SubnetName $cfg_file.Network.SubnetName `
  -SecurityGroupName $cfg_file.Network.NSGName_01 `
  -PublicIpAddressName $cfg_file.Network.PublicIP_01 `
  -Credential $credentials `
  -OpenPorts 80

# Update vmsize to "Standard_B1s" (only required with a student account)
$vm = Get-AzVM `
  -ResourceGroupName $cfg_file.RSGName_01  `
  -VMName $cfg_file.VM.Name_01
$vm.HardwareProfile.VmSize = "Standard_B1s"
Update-AzVM `
  -VM $vm `
  -ResourceGroupName $cfg_file.RSGName_01

# Install IIS
$Settings = '{"commandToExecute":"powershell Add-WindowsFeature Web-Server"}'

Set-AzVMExtension -ExtensionName "IIS" -ResourceGroupName $cfg_file.RSGName_01 -VMName $cfg_file.VM.Name_01 `
  -Publisher "Microsoft.Compute" -ExtensionType "CustomScriptExtension" -TypeHandlerVersion 1.4 `
  -SettingString $Settings -Location $cfg_file.Location

# Create a bastion
$subnetbastion = New-AzVirtualNetworkSubnetConfig -Name $cfg_file.Bastion.SubnetName -AddressPrefix $cfg_file.Bastion.SubnetAddressPrefix
$vnetbastion = New-AzVirtualNetwork -Name $cfg_file.Bastion.VnetName -ResourceGroupName $cfg_file.RSGName_01 -Location $cfg_file.Location -AddressPrefix $cfg_file.Bastion.VnetAddressPrefix -Subnet $subnetbastion
$publicipbastion = New-AzPublicIpAddress -ResourceGroupName $cfg_file.RSGName_01 -name $cfg_file.Bastion.PublicIP_Name -location $cfg_file.Location -AllocationMethod Static -Sku Standard
New-AzBastion -ResourceGroupName $cfg_file.RSGName_01 -Name $cfg_file.Bastion.Name -PublicIpAddress $publicipbastion -VirtualNetwork $vnetbastion
