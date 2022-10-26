# escape=`

# Install Dotnet Framework
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $verbosePreference='Continue';"]

# Copy Demo html
COPY \dist\index.html \inetpub\wwwroot\index.html

# Instal IIS https://hub.docker.com/_/microsoft-windows-servercore-iis 
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

SHELL [ "powershell" ]

# setup Remote IIS management

RUN Install-WindowsFeature Web-Mgmt-Service; New-ItemProperty -Path HKLM:\software\microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1 -Force; Set-Service -Name wmsvc -StartupType automatic;

# Add user for Remote IIS Manager Login

RUN net user iisadmin Password~1234 / ADD; net localgroup administrators iisadmin /add;