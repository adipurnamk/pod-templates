FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
RUN icacls 'C:\inetpub\wwwroot\' /grant 'IIS_IUSRS:(OI)(CI)F'
RUN icacls "'C:\inetpub\wwwroot\'  /grant 'IIS APPPOOL\DefaultAppPool:(OI)(CI)F'"
ARG source
WORKDIR /inetpub/wwwroot
Install IISRewrite Module
RUN Invoke-WebRequest http://download.microsoft.com/download/D/D/E/DDE57C26-C62C-4C59-A1BB-31D58B36ADA2/rewrite_amd64_en-US.msi -OutFile C:/inetpub/rewrite_amd64_en-US.msi
RUN powershell -Command Start-Process c:/inetpub/rewrite_amd64_en-US.msi -ArgumentList "/qn" -Wait
COPY ${source} .
