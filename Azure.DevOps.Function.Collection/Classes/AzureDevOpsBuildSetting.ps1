class AzureDevOpsBuildSetting {
    [object]$private:Branches
    [object]$private:Artifacts
    [object]$private:ArtifactTypesToDelete
    [int]$private:DaysToKeep
    [int]$private:MinimumToKeep
    [bool]$private:DeleteBuildRecord
    [bool]$private:DeleteTestResults
    hidden [object]$private:Raw

    AzureDevOpsBuildSetting($Value) {
        $this.Branches = $Value.branches
        $this.Artifacts = $Value.artifacts
        $this.ArtifactTypesToDelete = $Value.artifactTypesToDelete
        $this.DaysToKeep = $Value.daysToKeep
        $this.MinimumToKeep = $Value.minimumToKeep
        $this.DeleteBuildRecord = $Value.deleteBuildRecord
        $this.DeleteTestResults = $Value.deleteTestResults
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsBuildSetting[]]Get([string]$Setting) {
        $buildSetting = [AzureDevOps]::InvokeRequest()
        $output = $buildSetting | ForEach-Object {
            [AzureDevOpsBuildSetting]::new($_.$Setting)
        }
        return $output
    }
}