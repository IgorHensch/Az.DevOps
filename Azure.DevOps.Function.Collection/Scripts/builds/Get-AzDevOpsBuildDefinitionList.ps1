function Get-AzDevOpsBuildDefinitionList {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Definitions.
    .DESCRIPTION
        Gets Build Definition List from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildDefinitionList -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildDefinitionList -Project 'ProjectName' -Name 'BuildDefinitionName'
    .NOTES
        PAT Permission Scope: vso.build
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [string]$Name = '*'
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildDefinitionList]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}