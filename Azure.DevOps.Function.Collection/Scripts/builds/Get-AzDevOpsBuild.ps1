function Get-AzDevOpsBuild {
    <#
    .SYNOPSIS
        Gets Azure DevOps Builds.
    .DESCRIPTION
        Gets Builds from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Id = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('build/builds', $script:sharedData.ApiVersion, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.id -imatch "^$Id$" }
    }
    catch {
        throw $_
    }
}