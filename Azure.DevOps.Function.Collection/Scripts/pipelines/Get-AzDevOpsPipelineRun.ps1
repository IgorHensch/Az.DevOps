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

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$PipelineName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
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
            $request = [WebRequestAzureDevOpsCore]::Get("pipelines/$($param.PipelineId)/runs", $script:sharedData.ApiVersion, $param.Project, $null, $null)
            Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" } 
        }
        catch {
            throw $_
        }
    }
}