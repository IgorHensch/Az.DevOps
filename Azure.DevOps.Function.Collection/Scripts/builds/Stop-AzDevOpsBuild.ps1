function Stop-AzDevOpsBuild {
    <#
    .SYNOPSIS
        Cancel Azure DevOps Build Pipeline.
    .DESCRIPTION
        Cancel Build Pipeline in Azure Devops Pipeline.
    .LINK
        Get-AzDevOpsBuild
    .EXAMPLE
        Stop-AzDevOpsBuild -Name 'ProjectName' -Id 'BuildId'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId' | Stop-AzDevOpsBuild
    .NOTES
        PAT Permission Scope: vso.build_execute
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to queue a build, update build properties, and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project = $Project
                    BuildId = $Id
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
            $script:body = @{
                status = "cancelling"
            } | ConvertTo-Json -Depth 2
            $script:buildId = $param.BuildId
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuild]::new([AzureDevOps]::InvokeRequest())
        }
        catch {
            throw $_
        }
    }
}
