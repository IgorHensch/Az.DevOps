class AzureDevOpsGitRepositorie {
    [string]$private:Name
    [string]$private:Id
    [string]$private:Project
    [string]$private:DefaultBranch
    [string]$private:Size
    [string]$private:Url
    [string]$private:RemoteUrl
    [string]$private:SshUrl
    [string]$private:WebUrl
    [bool]$private:IsDisabled
    [bool]$private:IsInMaintenance
    hidden [object]$private:Raw

    AzureDevOpsGitRepositorie ($Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Project = $Value.project.name
        $this.DefaultBranch = $Value.defaultBranch ? $Value.defaultBranch : 'None'
        $this.Size = [DataSizeFormat]::new($Value.size).FormatSize
        $this.Url = $Value.url
        $this.RemoteUrl = $Value.remoteUrl
        $this.SshUrl = $Value.sshUrl
        $this.WebUrl = $Value.webUrl
        $this.IsDisabled = $Value.isDisabled
        $this.IsInMaintenance = $Value.isInMaintenance
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitRepositorie[]]Get() {
        $repositories = [AzureDevOps]::InvokeRequest()
        $output = $repositories.ForEach{
            [AzureDevOpsGitRepositorie]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsGitRepositorie[]]Create() {
        $repoName = ($script:body | ConvertFrom-Json).name
        $projectName = $script:projectName
        $response = [AzureDevOps]::InvokeRequest()
        Write-Debug $repoName 
        if ($response) {
            while (-not (Get-AzDevOpsGitRepositorie -Project $projectName -Name $RepoName)) {}
            return Get-AzDevOpsGitRepositorie -Project $projectName -Name $RepoName
        }
        else {
            return $null
        }
    }
}