function Get-AzDevOpsBuildTimeline {
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
                    BuildUrl = (Get-AzDevOpsBuilds -Project $Project -Id $BuildId).url
                }
            }
            'Pipeline' {
                $param = @{
                    BuildUrl = $PipelineObject.url
                }
            }
        }
        $buildUri = "$($param.BuildUrl)/Timeline?api-version=$($script:sharedData.ApiVersion)"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $buildUri -Method Get -Headers $script:sharedData.Header)
        }
        catch {
            throw $_
        }
    }
}