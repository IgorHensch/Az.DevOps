function Rename-AzDevOpsGitRepositorie {
    [CmdletBinding(DefaultParameterSetName = 'General')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]  
        [string]$Project,
        [Parameter(Mandatory = $true, ParameterSetName = 'General')]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [PSCustomObject]$PipelineObject,
        [Parameter(ParameterSetName = 'General')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Pipeline')]
        [string]$NewName
    )
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'General' {
                $param = @{
                    Project = $Project
                    Name    = $Name
                }
            }
            'Pipeline' {
                $param = @{
                    Project = $PipelineObject.project.name
                    Name    = $PipelineObject.name
                }
            }
        }
        $gitRepositorie = Get-AzDevOpsGitRepositorie -Project $param.Project -Name $param.Name
        $gitRepositoriesUri = "$($gitRepositorie.url)?api-version=$($script:sharedData.ApiVersionPreview)"
        $bodyData = @{
            name = $NewName
        }
        $body = $bodyData | ConvertTo-Json
        try {
            $body 
            Invoke-RestMethod -Uri $gitRepositoriesUri -Body $body -Method Patch -Headers $script:sharedData.Header -ContentType 'application/json'
        }
        catch {
            throw $_
        }
    }
}