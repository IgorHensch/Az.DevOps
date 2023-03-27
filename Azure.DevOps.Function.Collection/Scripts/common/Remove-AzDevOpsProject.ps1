function Remove-AzDevOpsProject {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [switch]$Force
    )

    switch ($PSCmdlet.ParameterSetName) {
        'General' {
            $param = @{
                Name = $Name
            }
        }
        'Pipeline' {
            $param = @{
                Name = $PipelineObject.name
            }
        }
    }

    $Project = Get-AzDevOpsProject -Name $param.Name
    $ProjectUri = "$($Project.url)?api-version=$($script:sharedData.ApiVersion)"

    try {
        if ($Force) {
            Invoke-RestMethod -Uri $ProjectUri -Method Delete -Headers $script:sharedData.Header
            Write-Host "Project $($Project.name) has been deleted."
        }
        else {
            $Project
            $title = "Delete $($Project.name) Project."
            $question = 'Do you want to continue?'
            $choices = '&Yes', '&No'
            
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
            if ($decision -eq 0) {
                Invoke-RestMethod -Uri $ProjectUri -Method Delete -Headers $script:sharedData.Header
                Write-Host "Project $($Project.name) has been deleted."
            }
            else {
                Write-Host 'Canceled!'
            }
        }
    }
    catch {
        throw $_
    }
}