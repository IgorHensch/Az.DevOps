function Get-AzDevOpsBuildOption {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Options.
    .DESCRIPTION
        Gets Build Options from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildOption -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildOption -Project 'ProjectName' -Name 'OptionName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $buildDefinitionsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/build/options?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $buildDefinitionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}