<#
.SYNOPSIS
 Kurze Beschreibung das dieses Skript Daten aus dem Eventlog abfrägt
.DESCRIPTION
 Lange Beschreibung das dieses Skript Daten aus dem Eventlog Security abfrägt wie zb 4624 4625 4634, was jeweilig wären Anmeldung, fehlgeschlagene Anmeldung, Abmeldung

 Auch mehrzeilig ist möglicht etc
.PARAMETER EventId
 Der Parameter bestimmt welches Event abgefragt wird. Folgende Werte sind sinnvoll:
 4624 Anmeldung
 4625 fehlgeschlagene Anmeldung
 4634 Abmeldung
.PARAMETER Computername
 Computername welcher abgefragt wird
.PARAMETER Newest
 Die Anzahl der Events die Ausgegeben wird 
.EXAMPLE
 Get-EventLog.ps1 -EventId 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  998455 Okt 22 13:54  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998451 Okt 22 13:53  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998448 Okt 22 13:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998445 Okt 22 13:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998442 Okt 22 13:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

Gibt die aktuellsten 5 AnmeldeEvents aus .
.EXAMPLE
Get-EventLog.ps1 -EventId 4624 -Verbose
AUSFÜHRLICH: Optionale Ausgabe

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  998458 Okt 22 13:55  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998455 Okt 22 13:54  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998451 Okt 22 13:53  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998448 Okt 22 13:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  998445 Okt 22 13:52  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

Gibt die aktuellsten 5 Anmeldeevents aus mit einer Verbose Ausgabe
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
#>
[cmdletBinding()]
param(
[string]$Computername = "localhost",

[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5

)

Write-Verbose -Message "Optionale Ausgabe"
Get-EventLog -LogName Security -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest

