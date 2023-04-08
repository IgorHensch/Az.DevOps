function Get-AzDevOpsFeedPackages {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Packages 
    .DESCRIPTION
        Gets Feed Packages from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsArtifactFeeds
    .EXAMPLE
        Get-AzDevOpsFeedPackages -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPackages -FeedName 'FeedName' -Name 'PackageName'
    .EXAMPLE
        Get-AzDevOpsArtifactFeeds | Get-AzDevOpsFeedPackages
    .EXAMPLE
        Get-AzDevOpsArtifactFeeds -Name 'FeedName' | Get-AzDevOpsFeedPackages
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
        $artifactFeedsUri = "$($param.FeedUrl)/packages?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $artifactFeedsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}