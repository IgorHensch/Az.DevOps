function Get-AzDevOpsBuildDefinition {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Definitions.
    .DESCRIPTION
        Gets Build Definition from Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildDefinition -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildDefinition -Project 'ProjectName' -Name 'BuildDefinitionName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    $buildDefinitionsUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/build/definitions?api-version=$($script:sharedData.ApiVersion)"
    try {
        Write-Output -InputObject (Invoke-RestMethod -Uri $buildDefinitionsUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}