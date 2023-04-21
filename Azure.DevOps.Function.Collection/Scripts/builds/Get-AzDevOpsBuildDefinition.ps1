function Get-AzDevOpsBuildDefinition {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Definitions.
    .DESCRIPTION
        Gets Build Definition from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildDefinition -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildDefinition -Project 'ProjectName' -Name 'BuildDefinitionName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('build/definitions', $script:sharedData.ApiVersion, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}