function Get-AzDevOpsPersonalAccessToken {
    <#
    .SYNOPSIS
        Gets Azure DevOps Personal Access Token.
    .DESCRIPTION
        Gets Personal Access Token from Azure Devops.
    .LINK
        Get-AzDevOpsUser
    .EXAMPLE
        Get-AzDevOpsPersonalAccessToken -Descriptor 'Descriptor' 
    .EXAMPLE
        Get-AzDevOpsPersonalAccessToken -Descriptor 'Descriptor' -DisplayName 'TokenName'
    .EXAMPLE
        Get-AzDevOpsUser -PrincipalName 'PrincipalName' | Get-AzDevOpsPersonalAccessToken
    .NOTES
        PAT Permission Scope: vso.tokenadministration
        Description: Grants the ability to manage (view and revoke) existing tokens to organization administrators.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$Descriptor,
        [string]$DisplayName = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    process {
        try {
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $param = @{
                        Descriptor = $Descriptor
                    }
                }
                'Pipeline' {
                    $param = @{
                        Descriptor = $PipelineObject.Descriptor
                    }
                }
            }
            $script:descriptor = $param.Descriptor
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsPersonalAccessToken]::Get().where{ $_.DisplayName -imatch "^$DisplayName$" } 
        }
        catch {
            throw $_
        }
    }
}