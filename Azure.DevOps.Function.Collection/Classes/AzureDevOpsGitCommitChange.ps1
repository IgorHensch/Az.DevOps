class AzureDevOpsGitCommitChange {
    [string]$private:Path
    [bool]$private:IsFolder
    [string]$private:ObjectId
    [string]$private:OriginalObjectId
    [string]$private:CommitId
    [string]$private:GitObjectType
    [string]$private:ChangeType
    hidden [object]$private:Raw

    AzureDevOpsGitCommitChange($Value) {
        $this.Path = $Value.item.path
        $this.IsFolder = $Value.item.isFolder
        $this.ObjectId = $Value.item.objectId
        $this.OriginalObjectId = $Value.item.originalObjectId
        $this.CommitId = $Value.item.commitId
        $this.GitObjectType = $Value.item.gitObjectType
        $this.ChangeType = $Value.changeType
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsGitCommitChange[]]Get() {
        $gitCommitChanges = [AzureDevOps]::InvokeRequest().changes
        $output = $gitCommitChanges | ForEach-Object {
            [AzureDevOpsGitCommitChange]::new($_)
        }
        return $output
    }
}