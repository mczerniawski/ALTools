@{
    Severity = @('Error', 'Warning', 'Information')
    IncludeRules = @(
                  
                   )

    Rules = @{
        PSPlaceCloseBrace = @{
            Enable = $true
            IgnoreOneLineBlock = $true
            NewLineAfter = $true
        }

        PSPlaceOpenBrace = @{
            Enable = $true
            OnSameLine = $true
            NewLineAfter = $true
            IgnoreOneLineBlock = $true
        }

        PSUseConsistentWhitespace = @{
            Enable = $false
            CheckOpenBrace = $true
            CheckOpenParen = $true
            CheckOperator = $true
            CheckSeparator = $true
            CheckInnerBrace = $false
        }
    }
}
