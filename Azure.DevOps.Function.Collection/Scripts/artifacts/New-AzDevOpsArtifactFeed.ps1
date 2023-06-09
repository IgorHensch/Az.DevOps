function New-AzDevOpsArtifactFeed {
    <#
    .SYNOPSIS
        Creates new Azure DevOps Artifact Feed.
    .DESCRIPTION
        Creates new Feed in Azure Devops Artifact.
    .EXAMPLE
        New-AzDevOpsArtifactFeed -Name 'FeedName'
    .EXAMPLE
        New-AzDevOpsArtifactFeed -Name 'FeedName' -Project 'ProjectName'
    .EXAMPLE
        New-AzDevOpsArtifactFeed -Project 'ProjectName' -Name 'FeedName'
    .EXAMPLE
        New-AzDevOpsArtifactFeed    -Project 'ProjectName' `
                                    -Name 'FeedName' `
                                    -Description 'Description' `
                                    -Capabilities 'defaultCapabilities' `
                                    -HideDeletedPackageVersions $true `
                                    -BadgesEnabled $true `
                                    -UpstreamEnabled $true `
                                    -UpstreamSources { @{ id = "40cea34f-c6ef-4898-b379-626926723a16"; name = "npmjs"; protocol = "npm"; location = "https://registry.npmjs.org/"; upstreamSourceType = "public"}, @{ id = "2a28a64e-8822-4bf7-bc7b-5f1475178b36"; name = "nuget.org"; protocol = "nuget"; location = "https://api.nuget.org/v3/index.json"; upstreamSourceType = "public"} }
    .NOTES
        PAT Permission Scope: vso.packaging_write
        Description: Grants the ability to create and read feeds and packages.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [string]$Project,
        [string]$Description,
        [string]$Capabilities = "defaultCapabilities",
        [bool]$HideDeletedPackageVersions = $true,
        [bool]$BadgesEnabled = $true,
        [bool]$UpstreamEnabled = $true,
        [scriptblock]$UpstreamSources = {
            @{
                id                 = "40cea34f-c6ef-4898-b379-626926723a16"
                name               = "npmjs"
                protocol           = "npm"
                location           = "https://registry.npmjs.org/"
                upstreamSourceType = "public"
            }
            @{
                id                 = "2a28a64e-8822-4bf7-bc7b-5f1475178b36"
                name               = "nuget.org"
                protocol           = "nuget"
                location           = "https://api.nuget.org/v3/index.json"
                upstreamSourceType = "public"
            }
        }
    )
    end {
        try {
            $script:body = @{
                description                = $Description
                hideDeletedPackageVersions = $HideDeletedPackageVersions
                badgesEnabled              = $BadgesEnabled
                name                       = $Name
                upstreamEnabled            = $UpstreamEnabled
                fullyQualifiedName         = $Name
                upstreamSources            = $UpstreamSources
                capabilities               = $Capabilities
            } | ConvertTo-Json -Depth 2
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectName = $Project
            [AzureDevOpsArtifactFeed]::Create()
        }
        catch {
            throw $_
        }
    }
}