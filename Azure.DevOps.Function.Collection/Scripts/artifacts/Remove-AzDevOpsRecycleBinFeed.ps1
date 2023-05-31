function Remove-AzDevOpsRecycleBinFeed {
    <#
    .SYNOPSIS
        Removes Azure DevOps Artifact deleted Feeds.
    .DESCRIPTION
        Removes deleted Feeds from Azure Devops Artifact Recycle Bin.
    .LINK
        Get-AzDevOpsRecycleBinFeed
    .EXAMPLE
        Remove-AzDevOpsRecycleBinFeed -FeedName 'FeedName'
    .EXAMPLE
        Remove-AzDevOpsRecycleBinFeed -FeedName 'FeedName' -Force
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeed -Name 'FeedName' | Remove-AzDevOpsRecycleBinFeed
    .NOTES
        PAT Permission Scope: vso.packaging_manage
        Description: Grants the ability to create, read, update, and delete feeds and packages.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
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
            Write-Output ($feed = Get-AzDevOpsRecycleBinFeed -Name $param.FeedName)
            $script:projectName = $feed.ProjectName
            $script:feedId = $feed.Id
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOps]::DeleteRequest($feed, $Force)
        }
        catch {
            throw $_
        }
    }
}