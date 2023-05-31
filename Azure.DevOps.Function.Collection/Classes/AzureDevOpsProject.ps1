class AzureDevOpsProject {
    [string]$private:Name
    [string]$private:Id
    hidden [string]$private:Url
    [string]$private:State
    [string]$private:DefaultTeam
    [string]$private:DefaultTeamId
    [int]$private:TeamCount
    [string]$private:Revision
    [string]$private:Visibility
    [string]$private:LastUpdateTime
    [string]$private:ProcessTemplate
    [bool]$private:IsGitEnabled
    [bool]$private:IsGitGitPermissionsInitialized
    [bool]$private:IsTfvcEnabled
    hidden [object]$private:RawProperties
    hidden [object]$private:Raw

    AzureDevOpsProject ([object]$Project, [object]$ProjectProperties) {
        $this.Name = $Project.name
        $this.Id = $Project.Id
        $this.Url = $Project.url
        $this.State = $Project.state
        $this.DefaultTeam = $Project.defaultTeam.name
        $this.Revision = $Project.revision
        $this.DefaultTeamId = $Project.defaultTeam.id
        $this.Visibility = $Project.visibility
        $this.LastUpdateTime = $Project.lastUpdateTime
        $this.ProcessTemplate = [AzureDevOpsProcessTemplate]::GetProcessName($ProjectProperties.where{ $_.name -eq 'System.ProcessTemplateType' }.value)
        $this.IsGitEnabled = $ProjectProperties.where{ $_.name -eq 'System.SourceControlGitEnabled' }.value
        $this.IsGitGitPermissionsInitialized = $ProjectProperties.where{ $_.name -eq 'System.SourceControlGitPermissionsInitialized' }.value
        $this.IsTfvcEnabled = $ProjectProperties.where{ $_.name -eq 'System.SourceControlTfvcEnabled' }.value
        $this.TeamCount = $ProjectProperties.where{ $_.name -eq 'System.Microsoft.TeamFoundation.Team.Count' }.value
        $this.RawProperties = $ProjectProperties
        $this.Raw = $Project
    }
    hidden static [AzureDevOpsProject[]]Get() {
        $projects = [AzureDevOps]::InvokeRequest()
        function Get-AzDevOpsProjectPropertie {
            param (
                [string]$ProjectId
            )
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectId = $ProjectId
            return [AzureDevOps]::InvokeRequest()
        }
        $output = $projects.ForEach{
            Write-Debug "Project: $($_.name)"
            $properties = Get-AzDevOpsProjectPropertie -ProjectId $_.id
            [AzureDevOpsProject]::new($_, $properties)
        }
        return $output 
    }
    hidden static [AzureDevOpsProject[]]Create() {
        $body = $script:body
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            $projectName = $($body | ConvertFrom-Json).Name
            while (-not $(Get-AzDevOpsProject -Name $projectName) ) {}
            return Get-AzDevOpsProject -Name $projectName
        }
        else {
            return = $null
        }
    }
}