function Add-IntegrationServicePrincipal
{
<#

.SYNOPSIS
Creates a Service Principal for integrations and can stores client ID and client secret in a target KayVault.

.DESCRIPTION
Creates a Service Principal for integrations and can stores client ID and client secret in a target KayVault.

.PARAMETER IntegrationName
The Name of the integration that we are using this service principal for.

.EXAMPLE

#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=1)]
        [string] $IntegrationName,

        [Parameter(Mandatory=$true, Position=2)]
        [string] $SubscriptionRole,

        [Parameter(Mandatory=$false)]
        [string] $IntegrationDescription,

        [Parameter(Mandatory=$false)]
        [string] $KeyVaultName
    )

    ## WIP
}