function Test-DynamicParam
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
        
        New-DynamicParameter -Name Dynamic -Mandatory -Type string -ValueFromPipelineByPropertyName -ValidateSet @("Valid1","Valid2") -Dictionary $Dictionary
       
        $Dictionary
    }	
	
    begin
    {
        # Get any parent caller -Verbose, -Whatif, -Confirm and carry them through
        Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
    }

    process
    {
        write-output "Test-DynamicParam, before New-DynamicParameter -CreateVariables: $($Dynamic)"
        New-DynamicParameter -CreateVariables -BoundParameters $PSBoundParameters
        write-output "Test-DynamicParam, after New-DynamicParameter -CreateVariables: $($Dynamic)"
        
    }
}
