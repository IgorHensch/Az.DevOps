function Get-AzDevOpsBuildLease {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Leases.
    .DESCRIPTION
        Gets Build Leases from Azure Devops Pipelines.
    .LINK
        Get-AzDevOpsBuild
    .EXAMPLE
        Get-AzDevOpsBuildLease -Project 'ProjectName' -BuildId 'BuildId'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId' | Get-AzDevOpsBuildLease
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
        [string]$BuildId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project = $Project
                    BuildId = $BuildId
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.ProjectName
                    BuildId = $PipelineObject.Id
                }
            }
        }
        try {
            $script:buildId = $param.BuildId
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildLease]::Get()
        }
        catch {
            throw $_
        }
    }
}