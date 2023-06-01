class AzureDevOpsUserGroup {
    [string]$private:DisplayName
    [string]$private:Descriptor
    [string]$private:DirectoryAlias
    [string]$private:PrincipalName
    [string]$private:MailAddress
    [string]$private:Domain
    [string]$private:Origin
    [string]$private:OriginId
    [string]$private:SubjectKind
    [string]$private:MetaType
    [bool]$private:IsCrossProject
    hidden [object]$private:Raw

    AzureDevOpsUserGroup([object]$Value) {
        $this.DisplayName = $Value.displayName
        $this.DirectoryAlias = $Value.directoryAlias
        $this.PrincipalName = $Value.principalName
        $this.MailAddress = $Value.mailAddress
        $this.Domain = $Value.domain
        $this.Origin = $Value.origin
        $this.OriginId = $Value.originId
        $this.SubjectKind = $Value.subjectKind
        $this.MetaType = $Value.metaType
        $this.Descriptor = $Value.descriptor
        $this.IsCrossProject = $Value.isCrossProject
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsUserGroup[]]Get() {
        $userGroups = [AzureDevOps]::InvokeRequest()
        $output = $userGroups.ForEach{
            [AzureDevOpsUserGroup]::new($_)
        }
        return $output
    }
}