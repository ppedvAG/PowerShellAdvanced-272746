
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

function Test-PipeLineInput
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true, ValueFromPipeLine=$true, ValueFromPipeLineByPropertyName=$true)]
[string]$Name
)

    Write-Host -ForegroundColor Green -Object $Name

}

function Test-BPE
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true, ValueFromPipeLine=$true, ValueFromPipeLineByPropertyName=$true)]
[string]$Name
)

Begin
{
    Write-Verbose -Message "Läuft einmal am Anfang des Skriptes. Ideal zum initialisieren von Variablen, Importieren von Modulen etc"
}
Process
{   
    #Wird einmal für jedes übergebene Objekt ausgeführt
    Write-Host -ForegroundColor Green -Object $Name
}
End
{
    Write-Verbose -Message "Wird einmal am Schluss ausgeführt, zb zum bereinigen von Sessions oder gezieltem Löschen von Variablen"
}



}

function Import-NewAduserFromCSV
{
[cmdletBinding()]
param(
[Parameter(ValueFromPipeLineByPropertyName=$true)]
[string]$GivenName,

[Parameter(ValueFromPipeLineByPropertyName=$true)]
[string]$Surname,

[Parameter(Mandatory=$true, ValueFromPipeLineByPropertyName=$true)]
[string]$Name,

[Parameter(Mandatory=$true, ValueFromPipeLineByPropertyName=$true)]
[string]$SamAccountName,

[Parameter(ValueFromPipeLineByPropertyName=$true)]
[string]$Enabled,

[Parameter(ValueFromPipeLineByPropertyName=$true)]
[string]$Password,

[Parameter(ValueFromPipeLineByPropertyName=$true)]
[string]$Path,

[Parameter(ValueFromPipeLineByPropertyName=$true)]
[string]$Department
)

Begin
{
    Import-Module -Name ActiveDirectory
}
Process
{
    $SecPwd = ConvertTo-SecureString -String $Password -AsPlainText -Force
    New-ADUser -AccountPassword $SecPwd -GivenName $GivenName -Surname $Surname -Name $Name -Enabled ([bool]::Parse($Enabled)) -Department $Department -Path $Path 
}
End
{
    Remove-Module -Name ActiveDirectory
    $SecPwd = ""
}
}