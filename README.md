# About

[![Build status](https://github.com/rgl/windows-pe-init/workflows/Build/badge.svg)](https://github.com/rgl/windows-pe-init/actions?query=workflow%3ABuild)

This is a Windows PE Init application.

## Develop

Install [Chocolatey](https://chocolatey.org/install).

Install [MSYS2](https://community.chocolatey.org/packages/msys2) and [Go](https://community.chocolatey.org/packages/go):

```batch
choco install -y msys2 --params="'/NoPath'"
choco install -y go
```

Execute the following commands in a MSYS2 `bash` session.

Build and execute the application:

```bash
go generate ./...
CGO_ENABLED=0 GOAMD64=v3 go build -trimpath -ldflags "-s -w -H=windowsgui"
go version -m windows-pe-init.exe
pwsh -Command '(Get-Item windows-pe-init.exe).VersionInfo | Format-List'
./windows-pe-init.exe
```
