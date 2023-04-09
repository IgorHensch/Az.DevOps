function Get-AzDevOpsBuildDefinitions {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Definitions.
    .DESCRIPTION
        Gets Build Definitions in Azure Devops Pipelines.
    .EXAMPLE
        Get-AzDevOpsBuildDefinitions -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsBuildDefinitions -Project 'ProjectName' -Name 'BuildDefinitionName'
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