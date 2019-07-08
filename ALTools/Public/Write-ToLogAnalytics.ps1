function Write-ToLogAnalytics {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [ValidateNotNullOrEmpty()]
        [psobject[]]
        $PSObject,

        [Parameter(Mandatory = $false, HelpMessage = 'Name for Table to store Events in Azure Log Analytics',
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [string]
        $ALTableIdentifier,

        [Parameter(Mandatory = $false,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [string]
        $ALWorkspaceID,

        [Parameter(Mandatory = $false,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [string]
        $WorkspacePrimaryKey,

        [Parameter(Mandatory = $true,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [DateTime]
        $invocationStartTime,

        [Parameter(Mandatory = $true,
            ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
        [DateTime]
        $invocationEndTime

    )


    process {
        $batchId = [System.Guid]::NewGuid()
        #foreach ($PSObj in $PSObject) {
        $ObjectToAzureLogs = $PSObject
        $ObjectToAzureLogs | Add-Member -MemberType NoteProperty -Name 'InvocationId' -Value ([System.Guid]::NewGuid())
        $ObjectToAzureLogs | Add-Member -MemberType NoteProperty -Name 'invocationStartTime' -Value $invocationStartTime
        $ObjectToAzureLogs | Add-Member -MemberType NoteProperty -Name 'invocationEndTime' -Value $invocationEndTime
        $ObjectToAzureLogs | Add-Member -MemberType NoteProperty -Name 'BatchId' -Value $BatchId
        $ObjectToAzureLogs | Add-Member -MemberType NoteProperty -Name 'SourceComputer' -Value ($env:computername)
        $exportArguments = @{
            ALWorkspaceID       = $ALWorkspaceID
            WorkspacePrimaryKey = $WorkspacePrimaryKey
            ALTableIdentifier   = $ALTableIdentifier
            TimeStampField      = $invocationStartTime
            PSObject            = $ObjectToAzureLogs
        }
        Write-Verbose -Message "Writing {$($ObjectToAzureLogs.Count)} Objects to Azure Log with: WorkspaceID - {$ALWorkspaceID}, BatchID - {$BatchId} into Table - {$ALTableIdentifier}"

        $result = Export-ObjectToLogAnalytics @exportArguments
        if ($result -ne 200) {
            Write-Error -Message "Something went wrong with exporting to Azure Log - {ErrorCode: $($result.ErrorCode)}"
        }
        #}
    }
}