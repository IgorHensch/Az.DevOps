function Restore-AzDevOpsRecycleBinFeed {
    <#
    .SYNOPSIS
        Restore Azure DevOps Artifact deleted Feeds.
    .DESCRIPTION
        Restore deleted Feeds from Azure Devops Artifact Recycle Bin.
    .LINK
        Get-AzDevOpsRecycleBinFeed
    .EXAMPLE
        Restore-AzDevOpsRecycleBinFeed -FeedName 'FeedName'
    .EXAMPLE
        Restore-AzDevOpsRecycleBinFeed -FeedName 'FeedName' -Force
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Name 'FeedName' | Restore-AzDevOpsRecycleBinFeed
    .NOTES
        PAT Permission Scope: vso.packaging_manage
        Description: Grants the ability to create, read, update, and delete feeds and packages.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $param = @{
                    FeedName = $FeedName
                }
            }
            'Pipeline' {
                $param = @{
                    FeedName = $PipelineObject.name
                }
            }
        }
        try {
            $feed = Get-AzDevOpsRecycleBinFeed -Name $param.FeedName
            $script:body = @{
                op    = 'replace'
                path  = '/isDeleted'
                value = $false
            } | ConvertTo-Json -Depth 2 -AsArray
            $script:projectName = $feed.ProjectName
            $script:feedId = $feed.Id
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::InvokeRequest()
        }
        catch {
            throw $_
        }
    }
}