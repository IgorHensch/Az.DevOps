function Get-AzDevOpsPackageBadge {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Package Badge.
    .DESCRIPTION
        Gets Feed Package Badge from Azure Devops Artifact.
    .LINK
        Get-AzDevOpsFeedPackage
    .EXAMPLE
        Get-AzDevOpsPackageBadge -FeedName 'FeedName' -PackageName 'PackageName'
    .EXAMPLE
        Get-AzDevOpsFeedPackages -FeedName 'FeedName' | Get-AzDevOpsPackageBadge
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$FeedName,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$PackageName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    PackageUrl = (Get-AzDevOpsFeedPackage -FeedName $FeedName -Name $PackageName).url
                }
            }
            'Pipeline' {
                $param = @{
                    PackageUrl = $PipelineObject.url
                }
            }
        }
        $packageBadgeUri = "$($param.PackageUrl)/badge?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -ContentType 'image/svg+xml' -Uri $packageBadgeUri -Method Get -Headers $script:sharedData.Header).value
        }
        catch {
            throw $_
        }
    }
}