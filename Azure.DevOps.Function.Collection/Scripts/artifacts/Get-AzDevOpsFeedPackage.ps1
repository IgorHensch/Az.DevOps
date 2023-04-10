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
        Get-AzDevOpsArtifactFeed | Get-AzDevOpsFeedPackage
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Name 'FeedName' | Get-AzDevOpsFeedPackage
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
                    FeedUrl = (Get-AzDevOpsArtifactFeed -Name $FeedName).url
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