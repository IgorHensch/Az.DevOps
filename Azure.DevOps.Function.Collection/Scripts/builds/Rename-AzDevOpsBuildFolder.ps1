function Rename-AzDevOpsBuildFolder {
    <#
    .SYNOPSIS
        Rename Azure DevOps Folder.
    .DESCRIPTION
        Renmae Folder in Azure Devops Pipeline.
    .LINK
        Get-AzDevOpsBuildFolder
    .EXAMPLE
        Rename-AzDevOpsBuildFolder -Name 'ProjectName' -Path 'FolderPath' -NewPath 'NewFolderPath'
    .EXAMPLE
        Rename-AzDevOpsBuildFolder -Name 'ProjectName' -Path 'FolderPath' -NewPath 'NewFolderPath' -Description 'Description'
    .EXAMPLE
        Get-AzDevOpsBuildFolder -Project 'ProjectName' -Path 'FolderPath' | Rename-AzDevOpsBuildFolder -NewPath 'NewFolderPath'
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
        [Parameter(Mandatory = $true)]
        [string]$NewPath,
        [string]$Description
    )
    end {
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
            $script:body = @{
                path        = $NewPath
                description = $Description
            } | ConvertTo-Json
            $script:folderPath = $param.Path
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildFolder]::Create()
        }
        catch {
            throw $_
        }
    }
}
