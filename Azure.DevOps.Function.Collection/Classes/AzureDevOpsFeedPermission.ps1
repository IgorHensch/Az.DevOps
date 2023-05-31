class AzureDevOpsFeedPermission {
    [string]$private:Role
    [string]$private:IdentityDescriptor
    [string]$private:DisplayName
    [bool]$private:IsInheritedRole
    hidden [object]$private:Raw

    AzureDevOpsFeedPermission($Value) {
        $this.Role = $Value.role
        $this.IdentityDescriptor = $Value.identityDescriptor
        $this.DisplayName = $Value.displayName
        $this.IsInheritedRole = $Value.isInheritedRole
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsFeedPermission[]]Get() {
        $artifactFeedPermissions = [AzureDevOps]::InvokeRequest()
        $output = $artifactFeedPermissions | ForEach-Object {
            [AzureDevOpsFeedPermission]::new($_)
        }
        return $output
    }
}