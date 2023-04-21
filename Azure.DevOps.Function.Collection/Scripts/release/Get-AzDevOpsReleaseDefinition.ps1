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
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('release/definitions', $script:sharedData.ApiVersionPreview, $Project, 'vsrm.', $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
    }
    catch {
        throw $_
    }
}