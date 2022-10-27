# escape=`

# Install Dotnet Framework
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Instal Windows Server 2019 Core IIS https://hub.docker.com/_/microsoft-windows-servercore-iis 
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

# Define shell params
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

# Install IIS Web-Server with sub features and management tools:

# Get IIS web-server feature
RUN Get-WindowsFeature web-server

# Install IS web-server feature
RUN Install-windowsfeature web-server

# Install Windows Auth in IIS Feature 
RUN Install-WindowsFeature -Name Web-Windows-Auth –IncludeAllSubFeature

# web-asp-net45
RUN add-windowsfeature web-asp-net45

# Web-Net-Ext45
RUN add-windowsfeature Web-Net-Ext45

# Web-Net-Ext45
RUN add-windowsfeature Web-ISAPI-Ext

# Web-ISAPI-Filter
RUN add-windowsfeature Web-ISAPI-Filter

# Web-Log-Libraries
RUN add-windowsfeature Web-Log-Libraries

# Web-Request-Monitor
RUN add-windowsfeature Web-Request-Monitor

# Create IIS Create an application pool
RUN New-WebAppPool -Name "NewAppPool"

# Start IIS Application Pool
RUN Start-WebAppPool "NewAppPool"

# Create Site Directory
RUN New-Item -ItemType Directory -Force -Path "C:\inetpub\testsite"

# Copy Site files
COPY "\dist\index.html" "C:\inetpub\testsite"

# Create nes site in IIS
RUN New-IISSite -Name "TestSite" -BindingInformation "*:8080:" -PhysicalPath "C:\inetpub\testsite"

# Create Web Binding
RUN New-WebBinding -Name "TestSite"  -IP "*" -Port 443 -Protocol http


# Disable Anonymous authentication on IIS PENDING CHANGE SiteName
# RUN powershell Import-Module WebAdministration; Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/anonymousAuthentication' -Name Enabled -Value False -PSPath 'IIS:\' -Location 'SiteName'

# Enable Windows Authentication PENDING CHANGE SiteName
# RUN powershell Import-Module WebAdministration; Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/windowsAuthentication' -Name Enabled -Value True -PSPath 'IIS:\' -Location 'SiteName'
