#To add space to citrix VDIs, use below script.
#for citrix VDIs, 16mb hard disk is also created. So, check if capacityGB is > 1 GB.
#use diskpart to extend disk in OS.
#As we have one more hard disk, either 0 or 1 will extend the disk space. Volume 2 is in case, if any VDI has one more additional hard disk.

Import-Module VMware.VimAutomation.Core
Connect-VIServer vcenterserver
Add-PSSnapin citrix*

$vdilist = Get-Content 'C:\VDIs Need space.txt'
foreach ($vdi in $vdilist) {

    $size = (get-vm $vdi | Get-HardDisk | Where-Object {$_.capacityGB -ge 1} ).CapacityGB
    $sizeneeded = $size + 5
    get-vm $vdi | Get-HardDisk | Where-Object {$_.capacityGB -ge 1} | Set-HardDisk -CapacityGB $sizeneeded -Confirm:$false
    Invoke-Command -ComputerName $vdi -ScriptBlock {"rescan","select volume 0","extend" | diskpart}
    Invoke-Command -ComputerName $vdi -ScriptBlock {"rescan","select volume 1","extend" | diskpart}
    Invoke-Command -ComputerName $vdi -ScriptBlock {"rescan","select volume 2","extend" | diskpart}
}

