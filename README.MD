## Build

```
docker build -t iis-site .
```

## Serve
Start localhost

```
docker run -p 80:80 iis-site
```

## Check\List Containers
Get Info from all running containers
```
docker ps
```

## Inspect Specific Container

Using ID = a8c05b39fd4c as an example
```
 docker inspect a8c05b39fd4c
```

## Setting up IIS in docker

1. Instal IIS https://hub.docker.com/_/microsoft-windows-servercore-iis

```
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
```

2. Setup IIS

Install IIS Web-Server with sub features and management tools

```
RUN powershell Get-WindowsFeature web-server
RUN powershell Install-windowsfeature web-server
RUN powershell add-windowsfeature web-asp-net45
```

## Troulshooting

If Docker says a port is in even though its not, in an **Admin** PowerShell instance, run the following:

```
Stop-Service docker
Stop-service hns
Start-service hns
Start-Service docker
docker network prune
```