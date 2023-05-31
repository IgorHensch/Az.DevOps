class AzureDevOpsGitDeletedRepositorie {
    [string]$private:Name
    [string]$private:Id
    [string]$private:Project
    [string]$private:DeletedBy
    [string]$private:CreatedDate
    [string]$private:DeletedDate
    [object]$private:DeletedSince
    hidden [object]$private:Raw

    AzureDevOpsGitDeletedRepositorie ($Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Project = $Value.project.name
        $this.DeletedBy = $Value.deletedBy.uniqueName
        $this.CreatedDate = $Value.createdDate
        $this.DeletedDate = $Value.deletedDate
        $this.DeletedSince = [TimeSpan]::new([datetime]$Value.deletedDate, (Get-Date)).TimeSpan
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitDeletedRepositorie[]]Get([bool]$IsSoftDeleted) {
        function Get-AzDevOpsSoftDeletedGitRepositorie {
            $script:function = $MyInvocation.MyCommand.Name
            return [AzureDevOps]::InvokeRequest()
        }
        if ($IsSoftDeleted) {
            Write-Verbose "Get softdeleted repositories only"
            $repositories = Get-AzDevOpsSoftDeletedGitRepositorie
        }
        else {
            $repositories = [AzureDevOps]::InvokeRequest()
        }
        $output = $repositories.ForEach{
            [AzureDevOpsGitDeletedRepositorie]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsGitRepositorie]Restore() {
        $projectName = $script:projectName
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            while (-not (Get-AzDevOpsGitRepositorie -Project $projectName).where{ $_.id -eq $script:deletedRepositoryId }) {}
            return (Get-AzDevOpsGitRepositorie -Project $projectName).where{ $_.id -eq $script:deletedRepositoryId }
        }
        else {
            return $null
        }
    }
}