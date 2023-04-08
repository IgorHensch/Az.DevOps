function Get-AzDevOpsBuildChanges {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Id,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    BuildUrl = (Get-AzDevOpsBuilds -Project $Project -Id $Id).url
                }
            }
            'Pipeline' {
                $param = @{
                    BuildUrl = $PipelineObject.url
                }
            }
        }
        $buildChangesUri = "$($param.BuildUrl)/changes?api-version=$($script:sharedData.ApiVersion)&includeSourceChange=true"
        try {
            Write-Output -InputObject  (Invoke-RestMethod -Uri $buildChangesUri -Method Get -Headers $script:sharedData.Header).value
        }
        catch {
            throw $_
        }
    }
}