function Get-AzDevOpsRecycleBinFeedPackageVersions {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feed Packages by Version.
    .DESCRIPTION
        Gets deleted Feed Packages by Version from Azure Devops Artifact Recycle Bin.
    .LINK
        Get-AzDevOpsRecycleBinFeedPackages
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackageVersions -FeedName 'FeedName' -PackageName 'PackageName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackageVersions -FeedName 'FeedName' -PackageName 'PackageName' -Version 'PackageVersion'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackages -FeedName 'FeedName' | Get-AzDevOpsRecycleBinFeedPackageVersions'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackages -FeedName 'FeedName' -Name 'PackageName' | Get-AzDevOpsRecycleBinFeedPackageVersions
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$PackageName,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [string]$Version = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
        
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    RecycleBinFeedPackageUrl = (Get-AzDevOpsRecycleBinFeedPackages -FeedName $FeedName -name $PackageName).url
                    PackageName              = $PackageName
                }
            }
            'Pipeline' {
                $param = @{
                    RecycleBinFeedPackageUrl = $PipelineObject.url
                    PackageName              = $PipelineObject.name
                }
            }
        }
        $recycleBinFeedPackageVersions = "$($param.RecycleBinFeedPackageUrl)/Versions?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $recycleBinFeedPackageVersions -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Version$" }
        }
        catch {
            throw $_
        }
    }
}