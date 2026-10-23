[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[string]$Path,

[Validatelength(5,20)]
[string]$Name,

[ValidateRange(1,99)]
[int]$FileCount,

[ValidateRange(0,99)]
[int]$DirCount,

[switch]$Force
)

$TestDirPath = Join-Path -Path $Path -ChildPath $Name
if(Test-Path -Path $TestDirPath  -PathType Container)
{
    if($Force)
    {
        Remove-Item -Path $TestDirPath -Recurse 
    }
    else
    {# Wenn der Ordner vorhanden ist soll ein terminierender Fehler geworfen werden 
        Write-Error -Message "Ordner bereits vorhanden" -Category ResourceExists -CategoryActivity "Dir Creation" -CategoryReason "REsource vorhandne" -CategoryTargetName $TestDirPath -ErrorId "FC12" -TargetObject (Get-Item -Path $TestDirPath) -RecommendedAction "Verwenden Sie -Force oder löschen Sie den Ordner" -ErrorAction Stop
    }
}

$TestDir = New-Item -Path $Path -Name $Name -ItemType Directory

for($i = 1; $i -le $FileCount; $i++)
{
    $FileName = "File" + ("{0:D2}" -f $i) + ".txt"
    New-Item -Path $TestDir.FullName -Name $FileName -ItemType File
}

for($i = 1; $i -le $DirCount; $i++)
{
    $DirName = "Dir" + ("{0:D2}" -f $i)
    $subdir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileCount; $i++)
    {
        $FileName = "File" + ("{0:D2}" -f $j) + ".txt"
        New-Item -Path $subdir.FullName -Name $FileName -ItemType File  
    }
}