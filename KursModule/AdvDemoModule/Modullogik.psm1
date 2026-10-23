
function Test-Scope {
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$Eingabe
)

$a = "Vor Function"
Write-Host "Vor der Funktion: $a"
    function scope{
        param(
            [Parameter(Mandatory=$true)]
            [ValidateNotNullOrEmpty()]
            [string]$Eingabe
        )
        $a = $Eingabe
        Write-Host "Innerhalb der Funktion: $a"
    }

scope -Eingabe $Eingabe
Write-Host "Nach der Funktion: $a"

}