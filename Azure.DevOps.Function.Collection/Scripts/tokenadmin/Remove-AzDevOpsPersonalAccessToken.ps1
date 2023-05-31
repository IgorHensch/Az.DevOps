function Remove-AzDevOpsPersonalAccessToken {
    <#
    .SYNOPSIS
        Remove Azure DevOps Personal Access Token from any account.
    .DESCRIPTION
        Remove Personal Access Token from Azure Devops.
    .LINK
        Get-AzDevOpsPersonalAccessToken
    .EXAMPLE
        Remove-AzDevOpsPersonalAccessToken -AuthorizationId 'AuthorizationId' 
    .EXAMPLE
        Get-AzDevOpsPersonalAccessToken -Descriptor 'Descriptor' -DisplayName 'TokenName' | Remove-AzDevOpsPersonalAccessToken
    .NOTES
        PAT Permission Scope: vso.tokenadministration
        Description: Grants the ability to manage (view and revoke) existing tokens to organization administrators.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$AuthorizationId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    process {
        try {
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $param = @{
                        AuthorizationId = $AuthorizationId
                    }
                }
                'Pipeline' {
                    $param = @{
                        AuthorizationId = $PipelineObject.AuthorizationId
                    }
                }
            }
            $script:body = @{
                authorizationId = $param.AuthorizationId
            } | ConvertTo-Json -AsArray
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsPersonalAccessToken]::Revoke()
        }
        catch {
            throw $_
        }
    }
}