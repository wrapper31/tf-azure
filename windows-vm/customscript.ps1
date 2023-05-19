<# The following script installs IIS,VCDM software,Imports and installs GM public certs,creates a VCDM website,
   self-signed certificate and binds it to VCDM site #>

# install requried modules
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

#install IIS
Add-WindowsFeature Web-Server; Add-WindowsFeature Web-Asp-Net45; Add-WindowsFeature NET-Framework-45-Core; Add-WindowsFeature Web-Net-Ext45; Add-WindowsFeature Web-ISAPI-Ext; Add-WindowsFeature Web-ISAPI-Filter; Add-WindowsFeature Web-Mgmt-Console; Add-WindowsFeature Web-Scripting-Tools; Add-WindowsFeature Search-Service; Add-WindowsFeature Web-Filtering; Add-WindowsFeature Web-Basic-Auth; Add-WindowsFeature Web-Windows-Auth; Add-WindowsFeature Web-Default-Doc; Add-WindowsFeature Web-Http-Errors; Add-WindowsFeature Web-Static-Content; Install-WindowsFeature RDS-Licensing -IncludeAllSubFeature -IncludeManagementTools; Install-WindowsFeature RDS-RD-Server -IncludeAllSubFeature -IncludeManagementTools; Install-WindowsFeature RDS-Licensing-UI -IncludeAllSubFeature -IncludeManagementTools; Install-WindowsFeature RSAT-RDS-Licensing-Diagnosis-UI -IncludeAllSubFeature -IncludeManagementTools


#Install VCDM 
Start-Process -Wait -FilePath 'C:\temp\vCDM Client\ISSetupPrerequisites\Microsoft Visual C++ 2008 SP1\vcredist_x64.exe' -ArgumentList '/q' -passthru
Start-Process -Wait -FilePath 'C:\temp\vCDM Client\ISSetupPrerequisites\Microsoft Visual C++ 2010 SP1\vcredist_x86.exe' -ArgumentList '/q' -passthru
Start-Process -Wait -FilePath 'C:\temp\vCDM Client\ISSetupPrerequisites\VC 2013 Redist\VS2013_vcredist_x86.exe' -ArgumentList '/q' -passthru
Start-Process -Wait -FilePath 'C:\temp\vCDM Client\ISSetupPrerequisites\Microsoft DirectX10 June 2010\DXSETUP.exe' -ArgumentList '/silent' -passthru
Start-Process -Wait -FilePath 'C:\temp\vCDM Client\setup.exe' -ArgumentList '/wait' -NoNewWindow -passthru
Start-Process -Wait -FilePath 'C:\temp\vCDM Client\CDM Studio Setup\Vector CDM Studio vCDM.msi' -ArgumentList '/qn' -passthru

#install root CA
Import-Certificate -FilePath "C:\temp\cert1.crt" -CertStoreLocation Cert:\LocalMachine\Root


#create VCDM website
Import-Module WebAdministration
New-WebSite -Name "VCDMtest" -Port 8080 -HostHeader "VCDMtest" -PhysicalPath "C:\inetpub\app.publish"

#create a self-signed cert and bind it
New-SelfSignedCertificate -DnsName $env:computername -CertStoreLocation cert:\LocalMachine\My -FriendlyName "vcdm-test"
New-WebBinding -Name "VCDMtest" -Protocol https -Port 443
Get-ChildItem  -Path Cert:\LocalMachine\My | Where-Object {$_.FriendlyName -Match "vcdm-test"} | New-Item -Path IIS:\SslBindings\!443
New-WebAppPool -Name "vcdmTest"
Set-ItemProperty -Path IIS:\AppPools\vcdmTest -Name processmodel.identityType -Value 'LocalSystem'
Set-ItemProperty 'IIS:\Sites\VCDMtest' applicationPool vcdmTest

#restart server
Restart-Computer -Force
