class AzureDevOpsProcessTemplate {
    [string]$private:Value
    AzureDevOpsProcessTemplate($Value) {
        $this.Value = $Value
    }
    static [AzureDevOpsProcessTemplate]GetTemplateTypeId([string]$ProcessName) {
        $templateTypeId = $null
        switch ($ProcessName) {
            'Agile' {
                $templateTypeId = 'adcc42ab-9882-485e-a3ed-7678f01f66bc'
            }
            'Basic' {
                $templateTypeId = 'b8a3a935-7e91-48b8-a94c-606d37c3e9f2'
            }
            'CMMI' {
                $templateTypeId = '27450541-8e31-4150-9947-dc59f998fc01'
            }
            'Scrum' {
                $templateTypeId = '6b724908-ef14-45cf-84f8-768b5384da45'
            }
        }
        return $templateTypeId
    }
    static [AzureDevOpsProcessTemplate]GetProcessName([string]$ProcessID) {
        $processTemplate = $null
        switch ($ProcessID) {
            'adcc42ab-9882-485e-a3ed-7678f01f66bc' {
                $processTemplate = 'Agile'
            }
            'b8a3a935-7e91-48b8-a94c-606d37c3e9f2' {
                $processTemplate = 'Basic'
            }
            '27450541-8e31-4150-9947-dc59f998fc01' {
                $processTemplate = 'CMMI'
            }
            '6b724908-ef14-45cf-84f8-768b5384da45' {
                $processTemplate = 'Scrum'
            }
        }
        return $processTemplate
    }
    [string] ToString() {
        return $this.Value
    }
}