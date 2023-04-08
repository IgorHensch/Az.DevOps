function Get-AzDevOpsBuildLeases {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$BuildId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    BuildLeasesUrl = (Get-AzDevOpsBuilds -Project $Project -Id $BuildId).url
                }
            }
            'Pipeline' {
                $param = @{
                    BuildLeasesUrl = $PipelineObject.url
                }
            }
        }
        $buildLeasesUri = "$($param.BuildLeasesUrl)/leases?api-version=$($script:sharedData.ApiVersionPreview)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $buildLeasesUri -Method Get -Headers $script:sharedData.Header).value
        }
        catch {
            throw $_
        }
    }
}