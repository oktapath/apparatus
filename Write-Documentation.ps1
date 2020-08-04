Import-Module $PSScriptRoot\src\Apparatus.psd1 -Force -Verbose
New-MarkdownHelp -Module Apparatus -OutputFolder $PSScriptRoot\docs -Force
