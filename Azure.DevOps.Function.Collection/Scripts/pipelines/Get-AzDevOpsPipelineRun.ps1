function Get-AzDevOpsPipelineRun {
    <#
    .SYNOPSIS
        Gets Azure DevOps Pipeline Runs.
    .DESCRIPTION
        Gets Pipeline Runs from Azure Devops Pipelines.
    .LINK
        Get-AzDevOpsPipeline
    .EXAMPLE
        Get-AzDevOpsPipelineRun -Project 'ProjectName' -PipelineName 'PipelineName'
    .EXAMPLE
        Get-AzDevOpsPipelineRun -Project 'ProjectName' -PipelineName 'PipelineName' -Name 'PipelineRunName'
    .EXAMPLE
        Get-AzDevOpsPipeline -Project 'Project' -Name 'PipelineName' | Get-AzDevOpsPipelineRun
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$PipelineName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project    = $Project
                    PipelineId = (Get-AzDevOpsPipeline -Project $Project -Name $PipelineName).id
                }
            }
            'Pipeline' {
                $param = @{
                    Project    = $PipelineObject.project
                    PipelineId = $PipelineObject.id
                }
            }
        }
        try {
            $script:projectName = $param.Project
            $script:pipelineId = $param.PipelineId
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsPipelineRun]::Get().where{ $_.name -imatch "^$Name$" }  
        }
        catch {
            throw $_
        }
    }
}