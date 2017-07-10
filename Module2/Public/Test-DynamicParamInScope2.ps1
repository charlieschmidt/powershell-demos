function Test-DynamicParamInScope2
{
    [cmdletbinding()]
    param
    (
        [Parameter(Mandatory = $true)]        
        [string] $StaticRequired
    )	
    DynamicParam
    {
        $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        
        New-DynamicParameterInScope2 -Name Dynamic -Mandatory -Type string -ValueFromPipelineByPropertyName -ValidateSet @("Valid1", "Valid2") -Dictionary $Dictionary
       
        $Dictionary
    }	
	
    begin
    {
        # Get any parent caller -Verbose, -Whatif, -Confirm and carry them through
        Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    }

    process
    {
        write-output "Test-DynamicParam, before New-DynamicParameterInScope2 -CreateVariables: $($Dynamic)"
        New-DynamicParameterInScope2 -CreateVariables -BoundParameters $PSBoundParameters
        write-output "Test-DynamicParam, after New-DynamicParameterInScope2 -CreateVariables: $($Dynamic)"
        
    }
}
