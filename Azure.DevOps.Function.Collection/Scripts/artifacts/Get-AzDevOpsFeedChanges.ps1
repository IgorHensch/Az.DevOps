function Get-AzDevOpsFeedChanges {
    <#
    .SYNOPSIS
        Gets Azure DevOps Feed Changes
    .DESCRIPTION
        Gets Feed Changes from Azure Devops Artifact.
    .EXAMPLE
        Get-AzDevOpsFeedChanges
    .EXAMPLE
        Get-AzDevOpsFeedChanges -Name 'FeedName'
    #>

    [CmdletBinding()]
    param (
        [string]$Name = '*'
    )
    $feedChangesUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/feedchanges?api-version=$($script:sharedData.ApiVersionPreview)"
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $feedChangesUri -Method Get -Headers $script:sharedData.Header).feedChanges.feed | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}