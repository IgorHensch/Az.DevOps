function Get-AzDevOpsRecycleBinFeedPackageVersion {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feed Packages by Version.
    .DESCRIPTION
        Gets deleted Feed Packages by Version from Azure Devops Artifact Recycle Bin.
    .LINK
        Get-AzDevOpsRecycleBinFeedPackage
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackageVersion -FeedName 'FeedName' -PackageName 'PackageName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackageVersion -FeedName 'FeedName' -PackageName 'PackageName' -Version 'PackageVersion'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackage -FeedName 'FeedName' -Name 'PackageName' | Get-AzDevOpsRecycleBinFeedPackageVersion
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$PackageName,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [string]$Version = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
        
    )
    end {
        switch ($PSCmdlet.ParameterSetName) {
            'Default' {
                $recycleBinFeedPackage = Get-AzDevOpsRecycleBinFeedPackage -FeedName $FeedName -name $PackageName
                $param = @{
                    PackageId = $recycleBinFeedPackage.Id
                    Project   = $recycleBinFeedPackage.ProjectName
                    FeedId    = $recycleBinFeedPackage.FeedId
                }
            }
            'Pipeline' {
                $param = @{
                    PackageId = $PipelineObject.Id
                    Project   = $PipelineObject.ProjectName
                    FeedId    = $PipelineObject.FeedId
                }
            }
        }
        try {
            $script:feedId = $param.FeedId
            $script:projectName = $param.Project
            $script:packageId = $param.PackageId
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsRecycleBinFeedPackageVersion]::Get().where{ $_.Version -imatch "^$Version$" }
        }
        catch {
            throw $_
        }
    }
}