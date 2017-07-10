
#Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Exclude "*.Tests.ps1" -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Exclude "*.Tests.ps1" -Recurse -ErrorAction SilentlyContinue )
$Workflow = @( Get-ChildItem -Path $PSScriptRoot\Workflow\*.ps1 -Exclude "*.Tests.ps1" -Recurse -ErrorAction SilentlyContinue )


#Dot source the files
Foreach ($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}



$Functions = @()
Foreach ($import in $Public)
{
    try
    {
        $command = get-command ($import.name -replace ".ps1", "") -ErrorAction SilentlyContinue
        if ($Command.CommandType -eq "Function")
        {
            $Functions += $Command.Name
        }
    }
    catch
    {}
}

Foreach ($import in @($Workflow))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}


