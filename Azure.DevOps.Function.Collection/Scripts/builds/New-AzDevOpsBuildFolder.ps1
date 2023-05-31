function New-AzDevOpsBuildFolder {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Folder.
    .DESCRIPTION
        Creates new Folder in Azure Devops Pipeline.
    .EXAMPLE
        New-AzDevOpsBuildFolder -Name 'ProjectName' -Path 'FolderPath'
    .EXAMPLE
        New-AzDevOpsBuildFolder -Name 'ProjectName' -Path 'FolderPath' -Description 'Description'
    .NOTES
        PAT Permission Scope: vso.build_execute
        Description: Grants the ability to access build artifacts, including build results, definitions, and requests, 
        and the ability to queue a build, update build properties, and the ability to receive notifications about build events via service hooks.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,
        [string]$Description
    )
    end {
        try {
            $script:body = @{
                path        = $Path
                description = $Description
            } | ConvertTo-Json
            $script:folderPath = $Path
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsBuildFolder]::Create()
        }
        catch {
            throw $_
        }
    }
}
