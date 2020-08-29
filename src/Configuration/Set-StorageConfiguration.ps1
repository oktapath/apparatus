function Set-StorageConfiguration
{
<#
.SYNOPSIS

Scans the current subscription for any azure storage accounts that you have access to, and pushes a specific (or first found) connection string to a given Key Vault.

.DESCRIPTION

Does a full subscription scan for all the azure storage accounts and reads, either the first key with full permissions, or a specific key if $KeyName is used, independently of it's permission set.
Support resource group filtering, because most times there are several storage accounts that are not application-bound.
By specifying $KeyName, this script can be used to rotate storage account keys.

.PARAMETER VaultName

The name of the Key Vault that we want to push the connection strings to.

.PARAMETER ResourceGroupFilter

If present, specifies a regex -match against Resource Group names for the scan.

.PARAMETER KeyName

If present, specifies a specific key to be used to compose the connection string.
If specified and the key isn't found, it will throw.

.EXAMPLE

PS> Set-StorageConfiguration my-key-vault
Scans the current subscription for any azure storage accounts that you have access to, and pushes the first key, with full permissions, connection string for each account to the 'my-key-vault' Key Vault.

.EXAMPLE

PS> Set-StorageConfiguration my-key-vault -ResourceGroupFilter 'my-rg'
Scans the current subscription for any azure storage accounts, that are in Resource Groups that -match 'my-rg', and that you have access to, and pushes the first key, with full permissions, connection string for each account to the 'my-key-vault' Key Vault.

.EXAMPLE

PS> Set-StorageConfiguration my-key-vault -ResourceGroupFilter 'my-rg' -KeyName 'key99'
Scans the current subscription for any azure storage accounts, that are in Resource Groups that -match 'my-rg', and that you have access to, and pushes the key named 'key99' connection string for each account to the 'my-key-vault' Key Vault.
If any of the accounts don't have the 'key99' key, it will throw.

.NOTES

Assumes you're logged into Azure and in the right subscription.
#>

    [CmdletBinding()]
    param(
        [parameter(Mandatory = $true, Position = 1)]
        [string] $VaultName,

        [parameter(Mandatory = $false, Position = 2)]
        [string] $ResourceGroupFilter = '',

        [parameter(Mandatory = $false, Position = 3)]
        [string] $KeyName = ''
    )

    $accounts = Get-AzStorageAccount

    if($ResourceGroupFilter -ne '') {
        $accounts = $accounts | where { $_.ResourceGroupName -match $ResourceGroupFilter }
    }

    $accounts | foreach {
        $keys = $_ | Get-AzStorageAccountKey -Verbose

        if($KeyName -eq '') {
            # if we're not specifying $KeyName, take the first key where permissions are set to full
            $key = ($keys | where { $_.Permissions -eq 'Full' })[0]
        }
        else {
            $filteredKeys = $keys | where { $_.KeyName -eq $KeyName }

            if($filteredKeys.Count -eq 0) {
                throw "Couldn't find any keys that match the given name $KeyName"
            }

            $key = $filteredKeys[0]
        }

        if($null -ne $key) {
            $connectionString = "DefaultEndpointsProtocol=https;AccountName=$($_.StorageAccountName);AccountKey=$($key.Value);EndpointSuffix=core.windows.net"
            $kvWriteKeyName = "Storage--$($_.StorageAccountName)--$($key.KeyName)"
            Set-AzKeyVaultSecret -VaultName $VaultName -Name $kvWriteKeyName -SecretValue (ConvertTo-SecureString -String $connectionString -AsPlainText -Force) -Verbose
        }
    }
}
