# IIS Docker Image

## Powershell commands:

Before running any of the following commands you need to start powershell in the containers terminal:

```
powershell
```

### See IIS sites status

To check the sites in your IIS instance run:

``` powershell
Get-Website
```

The output should be something like:
```
Name             ID   State      Physical Path                  Bindings
----             --   -----      -------------                  --------
Default Web Site 1    Started    %SystemDrive%\inetpub\wwwroot  http *:80:
TestSite         1617 Stopped    C:\inetpub\testsite            http *:8080:
                 1708                                           http *:443:
                 51
```

## Docker Commands:

### Build

``` docker
docker build -t <your-container-name-here> .
```

### Serve
Start localhost

```
docker run -p 80:80 <your-container-name-here>
```

### Check\List Containers
Get Info from all running containers
```
docker ps
```

### Inspect Specific Container

Using ID = a8c05b39fd4c as an example
```
 docker inspect a8c05b39fd4c
```

## DcokerFile breakdown

### Setting up IIS in docker

Instal IIS https://hub.docker.com/_/microsoft-windows-servercore-iis

```
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
```

Setup IIS

Install IIS Web-Server with sub features and management tools

```
RUN powershell Get-WindowsFeature web-server
RUN powershell Install-windowsfeature web-server
RUN powershell add-windowsfeature web-asp-net45
```

### Troulshooting

If Docker throws an error telling you that a port is in use even though its not, in an **Admin** PowerShell instance, run the following to stop the docker services and prune for the ports status:

```
Stop-Service docker
Stop-service hns
Start-service hns
Start-Service docker
docker network prune
```