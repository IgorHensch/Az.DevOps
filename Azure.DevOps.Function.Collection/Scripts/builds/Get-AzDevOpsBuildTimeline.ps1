function Get-AzDevOpsBuildTimeline {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Timeline.
    .DESCRIPTION
        Gets Build Timeline from Azure Devops Pipelines.
    .LINK
        Get-AzDevOpsBuild
    .EXAMPLE
        Get-AzDevOpsBuildTimeline -Project 'ProjectName' -BuildId 'BuildId'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId' | Get-AzDevOpsBuildTimeline
    #>

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
                    BuildUrl = (Get-AzDevOpsBuild -Project $Project -Id $BuildId).url
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