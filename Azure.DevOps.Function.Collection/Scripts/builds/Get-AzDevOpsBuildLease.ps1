function Get-AzDevOpsBuildLease {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Leases.
    .DESCRIPTION
        Gets Build Leases from Azure Devops Pipelines.
    .LINK
        Get-AzDevOpsBuild
    .EXAMPLE
        Get-AzDevOpsBuildLease -Project 'ProjectName' -BuildId 'BuildId'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId' | Get-AzDevOpsBuildLease
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
                    BuildLeasesUrl = (Get-AzDevOpsBuild -Project $Project -Id $BuildId).url
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