## Build

```
docker build -t iis-site .
```

## Serve

```
docker run -p 80:80 iis-site
```

## Setting up IIS in docker


### Enable Remote Management in the Docker image

The first step to enable remote management is to install the Web-Mgmt-Service and configure it to automatically start when the container starts. Additionally, an admin user needs to be added to the container to allow the Remote IIS Manager UI to remotely connect and manage IIS

```
FROM microsoft/iis

SHELL [ "powershell" ]

#setup Remote IIS management

RUN Install-WindowsFeature Web-Mgmt-Service; \

New-ItemProperty -Path HKLM:\software\microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1 -Force; \

Set-Service -Name wmsvc -StartupType automatic;

#Add user for Remote IIS Manager Login

RUN net user iisadmin Password~1234 /ADD; \

net localgroup administrators iisadmin /add;
```


### Add an Admin user to the container image to allow IIS Remote Manager to login
### Connect to container using IIS Remote Manager


## Troulshooting

Issues with the ports serving:

In an Administrative PowerShell console, run the following:

```
Stop-Service docker
Stop-service hns
Start-service hns
Start-Service docker
docker network prune
```