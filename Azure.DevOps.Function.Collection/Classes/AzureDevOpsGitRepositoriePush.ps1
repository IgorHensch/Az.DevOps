class AzureDevOpsGitRepositoriePush {
    [int]$private:PushId
    [string]$private:Repositorie
    [string]$private:Project
    [string]$private:PushedBy
    [datetime]$private:PushDate
    hidden [object]$private:Raw

    AzureDevOpsGitRepositoriePush([Object]$Value) {
        $this.PushId = $Value.pushId
        $this.Repositorie = $Value.repository.name
        $this.Project = $Value.repository.project.name
        $this.PushedBy = $Value.pushedBy.uniqueName
        $this.PushDate = $Value.date
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitRepositoriePush[]]Get() {
        $gitRepositoriePush = [AzureDevOps]::InvokeRequest()
        $output = $gitRepositoriePush | ForEach-Object {
            [AzureDevOpsGitRepositoriePush]::new($_)
        }
        return $output
    }
}