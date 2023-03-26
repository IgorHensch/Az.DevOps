function Get-AzDevOpsTeamMembers {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$TeamName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                TeamName = $TeamName
            }
        }
        'Pipeline' {
            $param = @{
                TeamName = $PipelineObject.name
            }
        }
    }

    $TeamUrl = (Get-AzDevOpsTeams -Name $param.TeamName).url
    $TeamMembersUri = "$TeamUrl/members?$mine=false&$top=10&$skip&api-version=$($script:sharedData.ApiVersionPreview)"
    $TeamMembersUri
    try {
        Write-Output -InputObject  (Invoke-RestMethod -Uri $TeamMembersUri -Method Get -Headers $script:sharedData.Header).value | Where-Object { $_.name -imatch "^$Name$" }
    }
    catch {
        throw $_
    }
}