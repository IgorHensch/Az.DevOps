function Get-AzDevOpsBuildDefinition {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Definition Details.
    .DESCRIPTION
        Gets Details from Azure Devops Pipelines Build Definition.
    .LINK
        Get-AzDevOpsBuildDefinitionList
    .EXAMPLE
        Get-AzDevOpsBuildDefinition -Project 'ProjectName' -DefinitionName 'BuildDefinitionName'
    .EXAMPLE
        Get-AzDevOpsBuildDefinitionList -Project 'ProjectName' -Name 'BuildDefinitionName' | Get-AzDevOpsBuildDefinition
    .NOTES
        PAT Permission Scope: vso.build
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$DefinitionName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project           = $Project
                    BuildDefinitionId = (Get-AzDevOpsBuildDefinitionList -Project $Project -Name $DefinitionName).Id
                }
            }
            'Pipeline' {
                $param = @{
                    Project           = $PipelineObject.ProjectName
                    BuildDefinitionId = $PipelineObject.Id
                }
            }
        }
        try {
            $script:buildDefinitionId = $param.BuildDefinitionId
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildDefinition]::Get()
        }
        catch {
            throw $_
        }
    }
}