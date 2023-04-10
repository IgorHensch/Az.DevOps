function Get-AzDevOpsTeamMember {
    <#
    .SYNOPSIS
        Gets Azure DevOps Team Members.
    .DESCRIPTION
        Gets Members from Azure Devops Team.
    .LINK
        Get-AzDevOpsTeam
    .EXAMPLE
        Get-AzDevOpsTeamMember -TeamName 'TeamName'
    .EXAMPLE
        Get-AzDevOpsTeamMember -TeamName 'TeamName' -Name 'MemberName'
    .EXAMPLE
        Get-AzDevOpsTeam -Name 'TeamName' | Get-AzDevOpsTeamMember
    #>

    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$TeamName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    TeamUrl = (Get-AzDevOpsTeam -Name $TeamName).url
                }
            }
            'Pipeline' {
                $param = @{
                    TeamUrl = $PipelineObject.url
                }
            }
        }
        $teamMembersUri = "$($param.TeamUrl)/members?$mine=false&$top=10&$skip&api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $teamMembersUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
        }
        catch {
            throw $_
        }
    }
}