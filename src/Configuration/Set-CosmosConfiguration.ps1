function Set-CosmosConfiguration
{
<#
.SYNOPSIS

Scans the current subscription for any cosmos db accounts that you have access to, and pushes their read and write connection strings to a given Key Vault.

.DESCRIPTION

Does a full subscription scan for all the cosmos databases and reads both read and write keys to compose all the available connection strings.
Can be set to use the secondary keys instead of the primary keys using the -SecondaryKeys switch.

.PARAMETER VaultName

The name of the Key Vault that we want to push the connection strings to.

.PARAMETER SecondaryKeys

[SWITCH] If present, it will use the secondary keys instead of the primary keys to compose the connection string.

.EXAMPLE

PS> Set-CosmosConfiguration my-key-vault
Scans the current subscription for any cosmos db accounts that you have access to, and pushes their read and write connection strings to the 'my-key-vault' Key Vault.

.EXAMPLE

PS> Set-CosmosConfiguration my-key-vault -SecondaryKeys
Scans the current subscription for any cosmos db accounts that you have access to, and pushes their read and write connection strings, using the secondary keys, to the 'my-key-vault' Key Vault.

.NOTES

Assumes you're logged into Azure and in the right subscription.
#>

    [CmdletBinding()]
    param(
        [parameter(Mandatory = $true, Position = 0)]
        [string] $VaultName,

        [switch] $SecondaryKeys
    )

    $cosmosDbs = Get-AzResource -ResourceType 'Microsoft.DocumentDb/databaseAccounts'

    $cosmosDbs | foreach {
        $keys = Invoke-AzResourceAction -Action listKeys -ResourceType 'Microsoft.DocumentDb/databaseAccounts' -ApiVersion '2019-08-01' -ResourceGroupName $_.ResourceGroupName -Name $_.Name -Confirm:$false -Force | Select-Object *
        $readKeys = Invoke-AzResourceAction -Action readonlykeys -ResourceType 'Microsoft.DocumentDb/databaseAccounts' -ApiVersion '2019-08-01' -ResourceGroupName $_.ResourceGroupName -Name $_.Name -Confirm:$false -Force | Select-Object *

        $key = switch($SecondaryKeys.IsPresent) {
            $true  { $keys.primaryMasterKey }
            $false { $keys.secondaryMasterKey }
        }

        $readKey = switch($SecondaryKeys.IsPresent) {
            $true  { $readKeys.primaryReadonlyMasterKey }
            $false { $readKeys.secondaryReadonlyMasterKey }
        }

        if($null -ne $key) {
            $connectionString = "AccountEndpoint=https://$($_.Name).documents.azure.com:443/;AccountKey=$key;"
            $kvWriteKeyName = "Cosmos--$((Get-Culture).TextInfo.ToTitleCase($_.Name).Replace('-', ''))--Write"
            Set-AzKeyVaultSecret -VaultName $VaultName -Name $kvWriteKeyName -SecretValue (ConvertTo-SecureString -String $connectionString -AsPlainText -Force) -Verbose
        }

        if($null -ne $readKey) {
            $readConnectionString = "AccountEndpoint=https://$($_.Name).documents.azure.com:443/;AccountKey=$readKey;"
            $kvReadKeyName = "Cosmos--$((Get-Culture).TextInfo.ToTitleCase($_.Name).Replace('-', ''))--Read"
            Set-AzKeyVaultSecret -VaultName $VaultName -Name $kvReadKeyName -SecretValue (ConvertTo-SecureString -String $readConnectionString -AsPlainText -Force) -Verbose
        }
    }
}
