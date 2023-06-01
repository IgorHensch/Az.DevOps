function Get-AzDevOpsRecycleBinFeedPackage {
    <#
    .SYNOPSIS
        Gets Azure DevOps deleted Feed Packages.
    .DESCRIPTION
        Gets deleted Feed Packages from Azure Devops Artifact Recycle Bin.
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackage -FeedName 'FeedName'
    .EXAMPLE
        Get-AzDevOpsRecycleBinFeedPackage -FeedName 'FeedName' -Name 'PackageName'
    .NOTES
        PAT Permission Scope: vso.packaging
        Description: Grants the ability to read feeds and packages. Also grants the ability to search packages.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [ValidateNotNullOrEmpty()]
        [string]$FeedName,
        [string]$Name = '*',
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject]$PipelineObject
    )
    end {
        try {
            switch ($PSCmdlet.ParameterSetName) {
                'Default' {
                    $Feed = Get-AzDevOpsArtifactFeed -Name $FeedName
                    $param = @{
                        Project = $Feed.ProjectName
                        FeedId  = $Feed.Id
                    }
                }
                'Pipeline' {
                    $param = @{
                        Project = $PipelineObject.ProjectName
                        FeedId  = $PipelineObject.Id
                    }
                }
            }
            $script:feedId = $param.FeedId
            $script:projectName = $param.Project
            $script:function = $MyInvocation.MyCommand.Name
            [AzureDevOpsRecycleBinFeedPackage]::Get().where{ $_.name -imatch "^$Name$" }
            [AzureDevOpsRecycleBinFeedPackage]::CleanScriptVariables()
        }
        catch {
            throw $_
        }
    }  
}