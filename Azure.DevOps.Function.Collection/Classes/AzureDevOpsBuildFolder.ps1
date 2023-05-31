class AzureDevOpsBuildFolder {
    [string]$Name
    [string]$private:Path
    $private:CreatedOn
    [string]$private:CreatedBy
    [string]$private:ProjectName
    hidden [object]$private:Raw

    AzureDevOpsBuildFolder($Value) {
        $this.Name = $Value.path.Split('\')[-1]
        $this.Path = $Value.path
        $this.CreatedOn = $Value.createdOn
        $this.CreatedBy = $Value.createdBy.uniqueName
        $this.ProjectName = $Value.project.name
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildFolder[]]Get() {
        $bildFolders = [AzureDevOps]::InvokeRequest()
        $output = $bildFolders | ForEach-Object {
            [AzureDevOpsBuildFolder]::new($_)
        }
        return $output
    }
    hidden static [AzureDevOpsBuildFolder[]]Create() {
        $folderPath = ($script:body | ConvertFrom-Json).path
        $project = $script:projectName
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            while (-not (Get-AzDevOpsBuildFolder -Project $project -Path $folderPath)) {}
            return Get-AzDevOpsBuildFolder -Project $project -Path $folderPath
        }
        else {
            return $null
        }
    }
}