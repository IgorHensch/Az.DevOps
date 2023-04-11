function New-AzDevOpsGitRepositorie {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Git Repositorie.
    .DESCRIPTION
        Creates new Git Repositorie in Azure Devops Repos.
    .EXAMPLE
        New-AzDevOpsGitRepositorie -Project 'ProjectName' -Name 'RepositorieName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$Name
    )
    $gitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/git/repositories/?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        name    = $Name
        project = @{ id = $((Get-AzDevOpsProject -Name $Project).id) }
    }
    $body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $gitRepositoriesUri -Body $body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}