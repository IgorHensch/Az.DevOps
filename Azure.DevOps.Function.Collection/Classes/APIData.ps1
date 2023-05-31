class APIData {
    [object]$private:Data
    APIData() {
        $api = @{
            'Approve-AzDevOpsRelease'                   = @{
                Uri         = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:project/_apis/release/approvals/$script:approvalId"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Approve-AzDevOpsPipeline'                  = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/pipelines/approvals"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $true
            }
            'Get-PipelineApproval'                      = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/pipelines/approvals/$script:approvalId"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsCurrentUser'                   = @{
                Uri         = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/profile/profiles/me"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsUser'                          = @{
                Uri         = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/graph/users"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGroup'                         = @{
                Uri         = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/graph/groups"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsPersonalAccessToken'           = @{
                Uri         = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/tokenadmin/personalaccesstokens/$script:descriptor"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsTeam'                          = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/teams"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?$('$mine=false&$top=100&$skip&')api-version=$($script:sharedData.ApiVersionPreview2)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsTeamMember'                    = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects/$script:projectId/teams/$script:teamId/members"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?$('$mine=false&$top=100&$skip&')api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsProject'                       = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsProcess'                       = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/process/processes"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsProjectPropertie'              = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects/$script:projectId/properties"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsSourceProvider'                = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/sourceproviders"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildSetting'                  = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/settings"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsPipeline'                      = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/pipelines"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsPipelineRun'                   = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/pipelines/$script:pipelineId/runs"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsRelease'                       = @{
                Uri         = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/release/releases"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsReleaseDefinition'             = @{
                Uri         = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/release/definitions"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsReleaseApproval'               = @{
                Uri         = "https://vsrm.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/release/approvals"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuild'                         = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/builds"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsPendingBuild'                  = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/builds"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?statusFilter=inProgress,notStarted&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildMetric'                   = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/metrics"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildOption'                   = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/options"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildFolder'                   = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/folders"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview2)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildResourceUsage'            = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/build/resourceusage"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview2)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsBuildChange'                   = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/Builds/$script:buildId/changes"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?&includeSourceChange=true&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildTimeline'                 = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/Builds/$script:buildId/Timeline"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsBuildLease'                    = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/Builds/$script:buildId/leases"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildDefinitionList'           = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/definitions"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsBuildDefinition'               = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/definitions/$script:buildDefinitionId"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsBuildDefinitionRevision'       = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/definitions/$script:buildDefinitionId/revisions"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsRecycleBinFeed'                = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/feedrecyclebin"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsRecycleBinFeedPackage'         = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId/RecycleBin/Packages"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsRecycleBinFeedPackageVersion'  = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId/RecycleBin/Packages/$script:packageId/Versions"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsArtifactFeed'                  = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsFeedPackage'                   = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId/packages"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsFeedView'                      = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId/views"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsFeedPermission'                = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId/permissions"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsArtifactGlobalPermission'      = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/packaging/globalpermissions"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsDeletedGitRepositorie'         = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/deletedrepositories"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitCommitList'                 = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/commits"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitCommitChange'               = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/commits/$script:commitId/changes"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Get-AzDevOpsGitRepositorie'                = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitRepositorieItem'            = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/items"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?recursionLevel=full&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitRepositoriePullRequest'     = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/pullrequests"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?recursionLevel=full&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitRepositoriePush'            = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/pushes"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?recursionLevel=full&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitRepositorieRef'             = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/refs"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?recursionLevel=full&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsGitRepositorieStat'            = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:repositorieName/stats/branches"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?recursionLevel=full&api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsSoftDeletedGitRepositorie'     = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/recycleBin/repositories"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'Get-AzDevOpsVariableGroup'                 = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/distributedtask/variablegroups"
                Mathod      = 'Get'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $true
            }
            'New-AzDevOpsProject'                       = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'New-AzDevOpsTeam'                          = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects/$script:projectName/teams"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'New-AzDevOpsVariableGroup'                 = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/distributedtask/variablegroups"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'New-AzDevOpsGitRepositorie'                = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'New-AzDevOpsArtifactFeed'                  = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'New-AzDevOpsFeedView'                      = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId/views"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'New-AzDevOpsBuildFolder'                   = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/folders"
                Mathod      = 'Put'
                Body        = $script:body
                Query       = "?path=$script:folderPath&api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Remove-AzDevOpsArtifactFeed'               = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/Feeds/$script:feedId"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $false
            }
            'Remove-AzDevOpsRecycleBinFeed'             = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/feedrecyclebin/$script:feedId"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $false
            }
            'Remove-AzDevOpsProject'                    = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects/$script:projectId"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Remove-AzDevOpsTeam'                       = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects/$script:projectId/teams/$script:teamId"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Remove-AzDevOpsGitRepositorie'             = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:gitRepositorieId"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = $null
                IsValuePath = $false
            }
            'Remove-AzDevOpsPersonalAccessToken'        = @{
                Uri         = "https://vssps.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/tokenadmin/revocations"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Remove-AzDevOpsVariableGroup'              = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/distributedtask/variablegroups/$script:variableGroupId"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = $null
                IsValuePath = $false
            }
            'Remove-AzDevOpsBuildFolder'                = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/folders"
                Mathod      = 'Delete'
                Body        = $null
                Query       = "?path=$script:folderPath&api-version=$($script:sharedData.ApiVersionPreview2)"
                ContentType = $null
                IsValuePath = $false
            }
            'Restore-AzDevOpsSoftDeletedGitRepositorie' = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/recycleBin/repositories/$script:deletedRepositoryId"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Restore-AzDevOpsRecycleBinFeed'            = @{
                Uri         = "https://feeds.$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/packaging/feedrecyclebin/$script:feedId"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json-patch+json'
                IsValuePath = $false
            }
            'Rename-AzDevOpsGitRepositorie'             = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/git/repositories/$script:gitRepositorieId"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Rename-AzDevOpsBuildFolder'                = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/folders"
                Mathod      = 'Post'
                Body        = $script:body
                Query       = "?path=$script:folderPath&api-version=$($script:sharedData.ApiVersionPreview2)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Rename-AzDevOpsTeam'                       = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/_apis/projects/$script:projectName/teams/$script:teamId"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Stop-AzDevOpsBuild'                        = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/build/Builds/$script:buildId"
                Mathod      = 'Patch'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersion)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
            'Update-AzDevOpsVariableGroup'              = @{
                Uri         = "https://$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$script:projectName/_apis/distributedtask/variablegroups/$script:variableGroupId"
                Mathod      = 'Put'
                Body        = $script:body
                Query       = "?api-version=$($script:sharedData.ApiVersionPreview)"
                ContentType = 'application/json'
                IsValuePath = $false
            }
        }
        $this.Data = $api.$($script:function)
    }
}