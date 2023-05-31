function Get-AzDevOpsFeedView {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Views.
    .DESCRIPTION
        Gets Feed Views from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedView -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedView -FeedName 'FeedName' -Name 'ViewName'
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [string]$Name = '*'
    )
    end {
        try {
            $Feed = Get-AzDevOpsArtifactFeed -Name $FeedName
            $script:feedId = $Feed.Id
            $script:projectName = $Feed.ProjectName
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsFeedView]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}