function Connect-AzDevOps {
    <#
    .SYNOPSIS
        Connect to Azure DevOps with a Personal Access Token.
    .DESCRIPTION
        Connect to Azure DevOps with a Personal Access Token.
    .EXAMPLE
        Connect-AzDevOps -Organization 'OrganizationName' -PersonalAccessToken 'PersonalAccessToken'
    #>

    [CmdletBinding()]
    param (        
        [Parameter(Mandatory = $true)]
        [string]$PersonalAccessToken,
        [Parameter(Mandatory = $true)]
        [string]$Organization,
        [string]$ApiVersion = '7.0',
        [string]$ApiVersionPreview = '7.0-preview.1',
        [string]$ApiVersion1Preview2 = '7.0-preview.2',
        [string]$CoreServer = 'dev.azure.com'
    )
    $script:sharedData = @{
        Header             = [Header]::new($PersonalAccessToken).Header
        Organization       = $Organization
        ApiVersion         = $ApiVersion
        ApiVersionPreview  = $ApiVersionPreview
        ApiVersionPreview2 = $ApiVersionPreview2
        CoreServer         = $CoreServer
    }
    try {
        [WebRequestAzureDevOpsCore]::Get('profile/profiles/me', $script:sharedData.ApiVersionPreview, $null, 'vssps.', $null).Value
    }
    catch {
        throw $_
    }
}