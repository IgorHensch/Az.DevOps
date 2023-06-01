function Get-AzDevOpsFeedPermission {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Permissions.
    .DESCRIPTION
        Gets Feed Permission from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedPermission -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPermission -FeedName 'FeedName' -Role 'administrator'
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [string]$Role = '*'
    )
    end {
        try {
            $Feed = Get-AzDevOpsArtifactFeed -Name $FeedName
            $script:feedId = $Feed.Id
            $script:projectName = $Feed.ProjectName
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsFeedPermission]::Get().where{ $_.role -imatch "^$Role$" }
        }
        catch {
            throw $_
        }
    }
}