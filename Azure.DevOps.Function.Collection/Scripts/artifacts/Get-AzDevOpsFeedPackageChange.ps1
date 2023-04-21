function Get-AzDevOpsFeedPackageChange {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Package Changes.
    .DESCRIPTION
        Gets Feed Package Changes from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsArtifactFeed
    .EXAMPLE
        Get-AzDevOpsFeedPackageChange -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsFeedPackageChange -FeedName 'FeedName' -Name 'PackageName'
    .EXAMPLE
        Get-AzDevOpsArtifactFeed | Get-AzDevOpsFeedPackageChange
    .EXAMPLE
        Get-AzDevOpsArtifactFeed -Name 'FeedName' | Get-AzDevOpsFeedPackageChange
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
        try {
            $request = [WebRequestAzureDevOpsCore]::Get($param.FeedUrl, 'packagechanges', $script:sharedData.ApiVersionPreview, $null) 
            Write-Output -InputObject $request.value.packageChanges.package.where{ $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}