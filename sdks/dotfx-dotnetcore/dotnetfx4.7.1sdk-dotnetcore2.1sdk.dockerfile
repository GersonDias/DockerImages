FROM microsoft/dotnet-framework:4.7.1-sdk-windowsservercore-1709 AS build
RUN powershell -Command "curl https://download.visualstudio.microsoft.com/download/pr/45f93081-cdb4-41c1-8d8d-e6c3bbf2872b/62d6a598956fdfe585acb1f15268d930/dotnet-sdk-2.1.403-win-x64.exe -OutFile dotnetsdk.exe"
RUN c:\dotnetsdk.exe -q
RUN del c:\dotnetsdk.exe
