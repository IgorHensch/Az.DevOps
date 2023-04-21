function Remove-AzDevOpsProject {
    <#
    .SYNOPSIS
        Removes Azure DevOps Project.
    .DESCRIPTION
        Removes Project from Azure Devops.
    .LINK 
        Get-AzDevOpsProject
    .EXAMPLE
        Remove-AzDevOpsProject -Name 'ProjectName'
    .EXAMPLE
        Remove-AzDevOpsProject -Name 'ProjectName' -Force
    .EXAMPLE
        Get-AzDevOpsProject -Name 'ProjectName' | Remove-AzDevOpsProject
    .EXAMPLE
        Get-AzDevOpsProject | Remove-AzDevOpsProject
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    Name = $Name
                }
            }
            'Pipeline' {
                $param = @{
                    Name = $PipelineObject.name
                }
            }
        }
        $project = Get-AzDevOpsProject -Name $param.Name
        try {
            $project
            [WebRequestAzureDevOpsCore]::Delete($project, $Force, $script:sharedData.ApiVersion).Value
        }
        catch {
            throw $_
        }
    }
}
