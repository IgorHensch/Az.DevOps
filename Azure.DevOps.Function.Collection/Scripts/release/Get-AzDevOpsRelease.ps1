function Get-AzDevOpsRelease {
    <#
    .SYNOPSIS
        Gets Azure DevOps Releases.
    .DESCRIPTION
        Gets Releases from Azure Devops Releases.
    .EXAMPLE
        Get-AzDevOpsRelease -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsRelease -Project 'ProjectName' -Name 'ReleaseName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('release/releases', $script:sharedData.ApiVersionPreview, $Project, 'vsrm.', $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}