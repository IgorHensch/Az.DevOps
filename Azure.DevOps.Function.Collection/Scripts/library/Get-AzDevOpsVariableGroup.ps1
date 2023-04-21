function Get-AzDevOpsVariableGroup {
    <#
    .SYNOPSIS
        Gets Azure DevOps Variable Groups.
    .DESCRIPTION
        Gets Variable Groups from Azure Devops Library.
    .EXAMPLE
        Get-AzDevOpsVariableGroup -Project 'ProjectName'
    .EXAMPLE
        Get-AzDevOpsVariableGroup -Project 'ProjectName' -Name 'VariableGroupName'
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [string]$Name = '*'
    )
    try {
        $request = [WebRequestAzureDevOpsCore]::Get('distributedtask/variablegroups', $script:sharedData.ApiVersionPreview, $Project, $null, $null)
        Write-Output -InputObject $request.value.where{ $_.name -imatch "^$Name$" }.foreach{ $_ | Add-Member @{ project = $Project } -PassThru }
    }
    catch {
        throw $_
    }
}