FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS node_env
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 10.8.0
ENV NODE_SHA256 9d03d6bc78d7375fa549005c9b12cf5da4b01ee52b60834107f5f603d82a68f2
RUN (New-Object System.Net.WebClient).DownloadFile('https://nodejs.org/dist/v{0}/node-v{0}-x64.msi' -f $env:NODE_VERSION, 'c:\\node.msi') ; \
    if ((Get-FileHash "c:\\node.msi" -Algorithm sha256).Hash -ne $env:NODE_SHA256) {exit 1} ;

RUN Start-Process -FilePath c:\node.msi -ArgumentList "/qn" -PassThru | Wait-Process
RUN rm c:\node.msi

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-nanoserver-1809 as build
COPY --from=node_env ["/program files/nodejs/", "/windows/system32/"]
