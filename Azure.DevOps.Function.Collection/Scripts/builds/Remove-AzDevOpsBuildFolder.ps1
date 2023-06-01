function Remove-AzDevOpsBuildFolder {
    <#
    .SYNOPSIS
        Removes Azure DevOps Git Repositorie.
    .DESCRIPTION
        Removes Git Repositorie from Azure Devops Repos.
    .EXAMPLE
        Remove-AzDevOpsBuildFolder -Name 'ProjectName' -Path 'FolderPath'
    .EXAMPLE
        Get-AzDevOpsBuildFolder -Project 'ProjectName' -Path 'FolderPath' | Remove-AzDevOpsBuildFolder
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
        [string]$Path,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    Project = $Project
                    Path    = $Path
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.ProjectName
                    Path    = $PipelineObject.Path
                }
            }
        }
        try {
            Write-Output ($buildFolder = Get-AzDevOpsBuildFolder @param)
            $script:projectName = $param.Project
            $script:folderPath = $param.Path
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($buildFolder, $Force)
        }
        catch {
            throw $_
        }
    }
}