function Get-AzDevOpsReleases {
    <#
    .SYNOPSIS
        Gets Azure DevOps Releases.
    .DESCRIPTION
        Gets Releases from Azure Devops Releases.
    .EXAMPLE
        Get-AzDevOpsReleases -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsReleases -Project 'ProjectName' -Name 'ReleaseName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $releaseUri = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/release/releases?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $releaseUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}