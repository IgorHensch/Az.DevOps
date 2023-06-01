function Get-AzDevOpsRecycleBinFeed {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feeds.
    .DESCRIPTION
        Gets deleted Feeds from Azure Devops Artifact Recycle Bin.
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Name 'FeedName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Project 'ProjectName' -Name 'FeedName'
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
            [AzureDevOpsRecycleBinFeed]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}