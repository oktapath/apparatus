# Import functions
. "$PSScriptRoot\Security\Get-MyUserObjectId.ps1"
. "$PSScriptRoot\Security\Initialize-SubscriptionRbac.ps1"

# Export functions
Export-ModuleMember -Function @(

    # Security
    'Get-MyUserObjectId'
    'Initialize-SubscriptionRbac'

)
