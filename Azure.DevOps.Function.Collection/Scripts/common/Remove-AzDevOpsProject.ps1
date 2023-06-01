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
    .NOTES
        PAT Permission Scope: vso.project_manage
        Description: Grants the ability to create, read, update, and delete projects and teams.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
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
        try {
            Write-Output ($project = Get-AzDevOpsProject -Name $param.Name)
            $script:projectId = $project.Id
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($project, $Force)
        }
        catch {
            throw $_
        }
    }
}
