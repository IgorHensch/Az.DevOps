function Get-AzDevOpsBuildOption {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Options.
    .DESCRIPTION
        Gets Build Options from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildOption -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildOption -Project 'ProjectName' -Name 'OptionName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('build/options', $script:sharedData.ApiVersion, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}