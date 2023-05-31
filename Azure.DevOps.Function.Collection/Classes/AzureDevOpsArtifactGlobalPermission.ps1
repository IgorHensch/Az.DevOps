class AzureDevOpsArtifactGlobalPermission {
    [string]$private:Role
    [string]$private:IdentityDescriptor
    hidden [object]$private:Raw

    AzureDevOpsArtifactGlobalPermission($Value) {
        $this.Role = $Value.role
        $this.IdentityDescriptor = $Value.identityDescriptor
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsArtifactGlobalPermission[]]Get() {
        $artifactGlobalPermissions = [AzureDevOps]::InvokeRequest()
        $output = $artifactGlobalPermissions | ForEach-Object {
            [AzureDevOpsArtifactGlobalPermission]::new($_)
        }
        return $output
    }
}