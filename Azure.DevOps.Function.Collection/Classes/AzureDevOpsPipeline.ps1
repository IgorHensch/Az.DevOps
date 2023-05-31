class AzureDevOpsPipeline {
    [string]$private:Name
    [int]$private:Id
    [int]$private:Revision
    [string]$private:Folder
    [string]$private:ProtectName
    hidden [object]$private:Raw

    AzureDevOpsPipeline($Value) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Revision = $Value.revision
        $this.Folder = $Value.folder
        $this.ProtectName = $script:project
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsPipeline[]]Get() {
        $script:project = $script:projectName
        $pipelines = [AzureDevOps]::InvokeRequest()
        $output = $pipelines | ForEach-Object {
            [AzureDevOpsPipeline]::new($_)
        }
        return $output
    }
}