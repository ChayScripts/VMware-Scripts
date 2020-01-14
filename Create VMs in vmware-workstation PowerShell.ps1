<#
1. Create new VM in vmware workstation. 
2. Change resources as needed like memory, cpu and disks. 
3. Install vmware tools.
4. Enable/disable shared folders.
5. Convert it to template.
#>

#For one VM.
function New-WorkStationVM {
    param (
        [CmdletBinding()]
        [Parameter(Position = 0, mandatory = $true)]
        [string] $VMName)
    Set-Location "c:\Program Files (x86)\VMware\VMware Workstation"
    .\vmrun.exe -T ws clone "D:\Permanent VMs\Template\Template2019\Template2019.vmx" d:\MyLab\$VMName\$VMName.vmx full -cloneName="$VMName"
}

#For multiple VMs
Set-Location "c:\Program Files (x86)\VMware\VMware Workstation"
Start-Process vmrun.exe -ArgumentList '-T ws clone "D:\Template\Template2019\Template2019.vmx" d:\MyLab\AD\AD.vmx full -cloneName="AD"'
Start-Sleep 60
Start-Process vmrun.exe -ArgumentList '-T ws clone "D:\Template\Template2019\Template2019.vmx" d:\MyLab\DHCP\DHCP.vmx full -cloneName="DHCP"'
