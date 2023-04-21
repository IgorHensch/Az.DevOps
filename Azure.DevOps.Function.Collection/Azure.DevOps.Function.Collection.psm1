class Header {
    [hashtable] $private:Header
    Header([string]$PAT) {
        $this.header = @{ Authorization = ("Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $null, $PAT)))) }
    }
}

class VarGroupJsonSchema {
    [bool] $private:Result
    VarGroupJsonSchema ([string]$String) {
        $HashTable = $String | ConvertFrom-Json | ConvertTo-PSFHashtable
        $this.Result = $HashTable.Keys.foreach{
            $HashTable.foreach{
                [bool]($keyName -cmatch '.+') -and
                ($_.$keyName | Get-Member -MemberType NoteProperty).Name -Contains 'IsSecret' -and
                ($_.$keyName | Get-Member -MemberType NoteProperty).Name -Contains 'Value'
            }
        }
    }
}
class AzureDevOpsCoreUri {
    [string]$private:Uri
    AzureDevOpsCoreUri([string]$_ref, [string]$project, [string]$apiVerion, [string]$subDomain, [string]$query) {
        $this.Uri = "https://$($subDomain)$($script:sharedData.CoreServer)/$($script:sharedData.Organization)/$project`/_apis/$_ref`?$($query)api-version=$($apiVerion)"
    }
}
class WebRequestAzureDevOpsCore {
    [PSCustomObject]$private:Value
    WebRequestAzureDevOpsCore ($Value) {
        $this.Value = $Value
    }
    static [WebRequestAzureDevOpsCore]Create([string]$project, [string]$body, [string]$_ref, [string]$apiVerion, [string]$subDomain, [string]$query) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri         = [AzureDevOpsCoreUri]::new($_ref, $project, $apiVerion, $subDomain, $query).Uri
                Body        = $body
                Method      = 'Post'
                Headers     = $script:sharedData.Header
                ContentType = 'application/json'
            }
            return Invoke-RestMethod @param
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
    static [WebRequestAzureDevOpsCore]Create([string]$url, [string]$body, [string]$apiVerion) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri         = "$url`?api-version=$($apiVerion)"
                Body        = $body
                Method      = 'Post'
                Headers     = $script:sharedData.Header
                ContentType = 'application/json'
            }
            return Invoke-RestMethod @param
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
    static [WebRequestAzureDevOpsCore]Delete([PSCustomObject]$object, [string]$_ref, [string]$project, [bool]$force, [string]$apiVerion, [string]$subDomain) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri     = [AzureDevOpsCoreUri]::new($_ref, $project, $apiVerion, [string]$subDomain, $null).Uri
                Method  = 'Delete'
                Headers = $script:sharedData.Header
            }
            if ($force) {
                return Invoke-RestMethod @param
            }
            else {
                $title = "Delete $($object.name)."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
                $decision = $global:Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod @param
                    return "$($object.name) has been deleted."
                }
                else {
                    return 'Canceled!'
                }
            }
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
    static [WebRequestAzureDevOpsCore]Delete([PSCustomObject]$object, [bool]$force, [string]$apiVerion) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri     = "$($object.url)?api-version=$($apiVerion)"
                Method  = 'Delete'
                Headers = $script:sharedData.Header
            }
            if ($force) {
                return Invoke-RestMethod @param
            }
            else {
                $title = "Delete $($object.name)."
                $question = 'Do you want to continue?'
                $choices = '&Yes', '&No'
                $decision = $global:Host.UI.PromptForChoice($title, $question, $choices, 1)
                if ($decision -eq 0) {
                    Invoke-RestMethod @param
                    return "$($object.name) has been deleted."
                }
                else {
                    return 'Canceled!'
                }
            }
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
    static [void]Update([string]$_ref, [string]$body, [string]$contentType, [string]$project, [string]$apiVerion, [string]$subDomain, [string]$query) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri         = [AzureDevOpsCoreUri]::new($_ref, $project, $apiVerion, $subDomain, $query).Uri
                Body        = $body
                Method      = 'Patch'
                Headers     = $script:sharedData.Header
                ContentType = $contentType
            }
            Invoke-RestMethod @param
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
        }
    }
    static [void]Update([string]$url, [string]$body, [string]$apiVerion) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri         = "$url`?api-version=$($apiVerion)"
                Body        = $body
                Method      = 'Patch'
                Headers     = $script:sharedData.Header
                ContentType = 'application/json'
            }
            Invoke-RestMethod @param
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
        }
    }
    static [void]Set([string]$_ref, [string]$body, [string]$project, [string]$apiVerion, [string]$subDomain, [string]$query) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri         = [AzureDevOpsCoreUri]::new($_ref, $project, $apiVerion, $subDomain, $query).Uri
                Body        = $body
                Method      = 'Put'
                Headers     = $script:sharedData.Header
                ContentType = 'application/json'
            }
            $global:Host.UI.Write($param.Uri)
            Invoke-RestMethod @param
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
        }
    }
    static [WebRequestAzureDevOpsCore]Get([string]$_ref, [string]$apiVerion, [string]$project, [string]$subDomain, [string]$query) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri     = [AzureDevOpsCoreUri]::new($_ref, $project, $apiVerion, $subDomain, $query).Uri
                Method  = 'Get'
                Headers = $script:sharedData.Header
            }
            if ($_ref -cnotmatch '(.+/me$|.+/feedchanges$)') {
                return (Invoke-RestMethod @param).value
            }
            else {
                return Invoke-RestMethod @param
            }
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
    static [WebRequestAzureDevOpsCore]Get([string]$url, [string]$_ref, [string]$apiVerion, [string]$query) {
        if($null -ne $script:sharedData) {
            $param = @{
                Uri     = "$($url)/$($_ref)?$($query)api-version=$($apiVerion)"
                Method  = 'Get'
                Headers = $script:sharedData.Header
            }
            if ($_ref -cnotmatch '(^Timeline$|^packagechanges$)') {
                return (Invoke-RestMethod @param).value
            }
            else {
                return (Invoke-RestMethod @param)
            }
        }
        else {
            $global:Host.UI.WriteWarningLine('Please use "Connect-AzDevOps" function to connect to Azure DevOps.')
            return $null
        }
    }
}

(Get-ChildItem -Path $PSScriptRoot\Scripts\*.ps1 -Recurse).foreach{
    . $_.FullName
}