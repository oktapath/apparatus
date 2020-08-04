function Add-IntegrationServicePrincipal
{
<#

.SYNOPSIS
Gets my user Object ID from the current AAD tenant.

.DESCRIPTION
Gets my user Object ID from the current AAD tenant.
If I'm a delegated guest in the current AAD tenant it will return the Object ID for the delegation, not the original account from the original tenant.

.EXAMPLE
Get-MyUserObjectId
Gets my user Object ID from the current AAD tenant.

#>

    [CmdletBinding()]
    param(
        [string] $IntegrationName,
        [string] $SubscriptionRole
    )

    $user = (Get-AzureRmContext).Account
    $adUser = Get-AzureRmADUser | where { $_.UserPrincipalName -match $user.Id }

    if($adUser -eq $null) {
        $adUser = Get-AzureRmADUser | where { $_.UserPrincipalName -match $user.Id.Replace("@", "_") }
    }

    if($adUser -eq $null) {
        throw "Couldn't find you in the AD!"
    }

    return $adUser.Id
}