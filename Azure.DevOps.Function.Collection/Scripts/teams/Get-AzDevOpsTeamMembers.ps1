function Get-AzDevOpsTeamMembers {
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
                    TeamUrl = (Get-AzDevOpsTeams -Name $TeamName).url
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