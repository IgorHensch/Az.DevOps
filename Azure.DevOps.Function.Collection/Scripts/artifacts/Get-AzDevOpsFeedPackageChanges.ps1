function Get-AzDevOpsFeedPackageChanges {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Package Changes.
    .DESCRIPTION
        Gets Feed Package Changes from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsArtifactFeeds
    .EXAMPLE
        Get-AzDevOpsFeedPackageChanges -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPackageChanges -FeedName 'FeedName' -Name 'PackageName'
    .EXAMPLE
        Get-AzDevOpsArtifactFeeds | Get-AzDevOpsFeedPackageChanges
    .EXAMPLE
        Get-AzDevOpsArtifactFeeds -Name 'FeedName' | Get-AzDevOpsFeedPackageChanges
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    FeedUrl = (Get-AzDevOpsArtifactFeeds -Name $FeedName).url
                }
            }
            'Pipeline' {
                $param = @{
                    FeedUrl = $PipelineObject.url
                }
            }
        }
        $feedPackageChangessUri = "$($param.FeedUrl)/packagechanges?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $feedPackageChangessUri -Method Get -Headers $script:sharedData.Header).packageChanges.package | Where-Object { $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}