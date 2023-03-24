function New-AzDevOpsArtifactFeed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$Project,
        [string]$Description,
        [string]$Capabilities = "defaultCapabilities",
        [bool]$HideDeletedPackageVersions = $true,
        [bool]$BadgesEnabled = $true,
        [bool]$UpstreamEnabled = $true,
        $UpstreamSources = {
            @{
                id = "40cea34f-c6ef-4898-b379-626926723a16"
                name = "npmjs"
                protocol = "npm"
                location = "https://registry.npmjs.org/"
                upstreamSourceType = "public"
            },
            @{
                id = "2a28a64e-8822-4bf7-bc7b-5f1475178b36"
                name = "nuget.org"
                protocol = "nuget"
                location = "https://api.nuget.org/v3/index.json"
                upstreamSourceType = "public"
            }
        }
    )

    $ArtifactFeedsUri = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$Project/_apis/packaging/feeds?api-version=$($script:sharedData.ApiVersion)"
    $bodyData = @{
        description = $Description
        hideDeletedPackageVersions = $HideDeletedPackageVersions
        badgesEnabled = $BadgesEnabled
        name = $Name
        upstreamEnabled = $UpstreamEnabled
        fullyQualifiedName = $Name
        upstreamSources = $UpstreamSources
        capabilities = $Capabilities
    }
    $Body = $bodyData | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $ArtifactFeedsUri -Body $Body -Method Post -Headers $script:sharedData.Header -ContentType 'application/json'
    }
    catch {
        throw $_
    }
}