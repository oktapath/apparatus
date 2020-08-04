param
(
    [parameter(Mandatory=$true, Position=0)]
    [string] $ApiKey
)

Publish-Module -Name $PSScriptRoot\src\Apparatus.psd1 -NuGetApiKey $ApiKey
