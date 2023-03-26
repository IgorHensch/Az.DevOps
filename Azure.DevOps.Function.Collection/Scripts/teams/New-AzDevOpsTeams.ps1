function New-AzDevOpsTeams {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$Description
    )

    $ProjectUrl = (Get-AzDevOpsProject -Name $Project).url
    $TeamsUri = "$ProjectUrl/teams?api-version=$($script:sharedData.ApiVersionPreview)"
    $bodyData = @{
        name        = $Name
        description = $Description
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $TeamsUri -Body $Body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}