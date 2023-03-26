function New-AzDevOpsGitRepositorie {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $GitRepositoriesUri = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/git/repositories/?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        name    = $Name
        project = @{ id = $((Get-AzDevOpsProject -Name $Project).id) }
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $GitRepositoriesUri -Body $Body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}