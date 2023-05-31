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