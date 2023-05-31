class AzureDevOpsTeam {
    [string]$private:Name
    [string]$private:Id
    [string]$private:Description
    [string]$private:ProjectName
    [string]$private:ProjectId
    [array]$private:Member
    [int]$private:MemberCount
    hidden [object]$private:TeamMemberRaw
    hidden [object]$private:Raw

    AzureDevOpsTeam([Object]$Value, $TeamMember) {
        $this.Name = $Value.name
        $this.Id = $Value.id
        $this.Description = $Value.description
        $this.ProjectName = $Value.projectName
        $this.ProjectId = $Value.projectId
        $this.Member = $TeamMember.uniqueName
        $this.MemberCount = $TeamMember.uniqueName.count
        $this.TeamMemberRaw = $TeamMember
        $this.Raw = $Value
    }
    hidden static [AzureDevOpsTeam[]]Get() {
        function Get-AzDevOpsTeamMember {
            param (
                [string]$ProjectId,
                [string]$TeamId
            )
            $script:function = $MyInvocation.MyCommand.Name
            $script:projectId = $ProjectId
            $script:teamId = $TeamId
            return [AzureDevOps]::InvokeRequest()
        }
        $teams = [AzureDevOps]::InvokeRequest()
        $output = $teams | ForEach-Object {
            $teamMember = Get-AzDevOpsTeamMember -ProjectId $_.projectId -TeamId $_.id
            [AzureDevOpsTeam]::new($_, $teamMember)
        }
        return $output
    }
    hidden static [AzureDevOpsTeam[]]Create() {
        $body = $script:body
        $response = [AzureDevOps]::InvokeRequest()
        if ($response) {
            $teamName = $($body | ConvertFrom-Json).name
            while (-not $(Get-AzDevOpsTeam -Name $teamName) ) {}
            return Get-AzDevOpsTeam -Name $teamName
        }
        else {
            return = $null
        }
    }
}