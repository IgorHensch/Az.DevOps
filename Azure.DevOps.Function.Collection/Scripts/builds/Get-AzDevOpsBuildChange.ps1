function Get-AzDevOpsBuildChange {
    <#
    .SYNOPSIS
        Gets Azure DevOps Build Changes.
    .DESCRIPTION
        Gets Build Changes from Azure Devops Pipelines.
    .LINK
        Get-AzDevOpsBuild
    .EXAMPLE
        Get-AzDevOpsBuildChange -Project 'ProjectName' -Id 'BuildId'
    .EXAMPLE
        Get-AzDevOpsBuild -Project 'ProjectName' -Id 'BuildId' | Get-AzDevOpsBuildChange
    #>

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
                    BuildUrl = (Get-AzDevOpsBuild -Project $Project -Id $Id).url
                }
            }
            'Pipeline' {
                $param = @{
                    BuildUrl = $PipelineObject.url
                }
            }
        }
        try {
            $request = [WebRequestAzureDevOpsCore]::Get($param.BuildUrl, 'changes', "$($script:sharedData.ApiVersion)&includeSourceChange=true", $null) 
            Write-Output -InputObject $request.value
        }
        catch {
            throw $_
        }
    }
}