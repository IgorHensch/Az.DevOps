function Get-AzDevOpsFeedPackage {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Packages.
    .DESCRIPTION
        Gets Feed Packages from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsArtifactFeed
    .EXAMPLE
        Get-AzDevOpsFeedPackage -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPackage -FeedName 'FeedName' -Name 'PackageName'
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Name 'FeedName' | Get-AzDevOpsFeedPackage
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $Feed = Get-AzDevOpsArtifactFeed -Name $FeedName
                $param = @{
                    Project = $Feed.ProjectName
                    FeedId  = $Feed.Id
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.ProjectName
                    FeedId  = $PipelineObject.Id
                }
            }
        }
        try {
            $script:feedId = $param.FeedId
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsFeedPackage]::Get().where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}