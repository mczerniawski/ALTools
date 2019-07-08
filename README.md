# Build Status

|Build Status|Branch|
|---|---|
|[![Build status](https://ci.appveyor.com/api/projects/status/aimyu88pb50g1h9d?svg=true)](https://ci.appveyor.com/project/mczerniawski/altools/branch/master)|master|
|[![Build status](https://ci.appveyor.com/api/projects/status/aimyu88pb50g1h9d?svg=true)](https://ci.appveyor.com/project/mczerniawski/altools/branch/dev)|dev|

---

## Index
<!-- TOC -->
- [What is ALTools](#What-is-pChecksAD)
- [Installation](#Installation)
- [How to Create Azure Log Worksapce](https://github.com/mczerniawski/ALTools/blob/master/docs/Create-AzureLog-Workspace.md)
- [How to Retrieve required information from existing Workspace](https://github.com/mczerniawski/ALTools/blob/master/docs/Get-WorkspaceID-PrimaryKey.md)
- [Run Examples](#Examples)
<!-- /TOC -->

## What is ALTools

`ALTools` is a simple micro-module to interact with [Azure Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs).

It is based on official [Microsoft documentation](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-collector-api).

In it's current state it is used to send custom PSObjects to Azure Logs.

## Installation

`ALTools` module is available on PowerShell Gallery so installation is quite easy:

```powershell
Install-Module ALTools
```

## Examples

To send `PowerShell Objects` to Azure Logs you will first need to get WorkspaceID and PrimaryKey. Use [this](https://github.com/mczerniawski/ALTools/blob/master/docs/Get-WorkspaceID-PrimaryKey.md) to get it.

Here are some examples of how to use this to send custom logs to Azure Logs

### Current running processes

Send all files from given path Azure Logs:

```powershell
Import-Module ALTools -Force

$invocationStartTime = [DateTime]::UtcNow
$object = Get-Process
$invocationEndTime = [DateTime]::UtcNow

$writeToLogAnalyticsSplat = @{
    ALWorkspaceID       = 'e2920363-xxxx-xxxx-xxxx-740exxxx801'
    invocationStartTime = $invocationStartTime
    PSObject            = $object
    ALTableIdentifier   = 'ALTools' #Your name for Azure Logs
    invocationEndTime   = $invocationEndTime
    WorkspacePrimaryKey = 'I5ZBxxxxxxxxxxxRkiy8uZ77rfTKKvzeI+g=='
}
Write-ToLogAnalytics @writeToLogAnalyticsSplat -Verbose
```

### Files from disk

Send all current running processes to Azure Logs:

```powershell
$invocationStartTime = [DateTime]::UtcNow
$object = Get-ChildItem -Path 'C:\AdminTools'
$invocationEndTime = [DateTime]::UtcNow
$writeToLogAnalyticsSplat = @{
    ALWorkspaceID       = 'e2920363-xxxx-xxxx-xxxx-740exxxx801'
    invocationStartTime = $invocationStartTime
    PSObject            = $object
    ALTableIdentifier   = 'ALTools' #Your name for Azure Logs
    invocationEndTime   = $invocationEndTime
    WorkspacePrimaryKey = 'I5ZBxxxxxxxxxxxRkiy8uZ77rfTKKvzeI+g=='
}
Write-ToLogAnalytics @writeToLogAnalyticsSplat -Verbose
```
