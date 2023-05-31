function Connect-AzDevOps {
    <#
    .SYNOPSIS
        Connect to Azure DevOps with a Personal Access Token.
    .DESCRIPTION
        Connect to Azure DevOps with a Personal Access Token.
    .EXAMPLE
        Connect-AzDevOps -Organization 'OrganizationName' -PersonalAccessToken 'PersonalAccessToken'
    .NOTES
        PAT Permission Scope: vso.profile
        Description: Grants the ability to read your profile, accounts, collections, projects, teams, and other top-level organizational artifacts.
    #>
    [CmdletBinding()]
    param (        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$PersonalAccessToken,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Organization,
        [string]$CoreServer = 'dev.azure.com'
    )
    end {
        $script:sharedData = @{
            Header             = [Header]::new($PersonalAccessToken).Header
            Organization       = $Organization
            ApiVersion         = '7.0'
            ApiVersionPreview  = '7.0-preview.1'
            ApiVersionPreview2 = '7.0-preview.2'
            CoreServer         = $CoreServer
        }
        try {
            Get-AzDevOpsCurrentUser
        }
        catch {
            throw $_
        }
    }
}