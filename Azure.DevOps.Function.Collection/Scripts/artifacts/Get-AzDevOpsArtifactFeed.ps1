function Get-AzDevOpsArtifactFeed {
    <#
    .SYNOPSIS
        Gets Azure DevOps Artifact Feeds. 
    .DESCRIPTION
        Gets Feeds from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsArtifactFeed
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Project 'ProjectName' -Name 'FeedName'
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding()]
    param (
        [string]$Project,
        [string]$Name = '*'
    )
    end {
        try {
            $script:projectName = $Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsArtifactFeed]::get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}