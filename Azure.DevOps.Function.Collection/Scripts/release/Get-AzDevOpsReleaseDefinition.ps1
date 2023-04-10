function Get-AzDevOpsReleaseDefinition {
    <#
    .SYNOPSIS
        Gets Azure DevOps Release Definitions.
    .DESCRIPTION
        Gets Release Definitions from Azure Devops Releases.
    .EXAMPLE
        Get-AzDevOpsReleaseDefinition -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsReleaseDefinition -Project 'ProjectName' -Name 'ReleaseDefinitionName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $releaseUri = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/release/definitions?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $releaseUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}