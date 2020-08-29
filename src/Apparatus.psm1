# Import functions
. "$PSScriptRoot\Configuration\Set-CosmosConfiguration.ps1"
. "$PSScriptRoot\Configuration\Set-StorageConfiguration.ps1"
. "$PSScriptRoot\Git\New-PullRequest.ps1"
. "$PSScriptRoot\Security\Get-MyUserObjectId.ps1"
. "$PSScriptRoot\Security\Initialize-SubscriptionRbac.ps1"

# Export functions
Export-ModuleMember -Function @(

    # Configuration
    'Set-CosmosConfiguration'
    'Set-StorageConfiguration'

    # Git
    'New-PullRequest'

    # Security
    'Get-MyUserObjectId'
    'Initialize-SubscriptionRbac'

)
