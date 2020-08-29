---
external help file: Apparatus-help.xml
Module Name: Apparatus
online version:
schema: 2.0.0
---

# Set-StorageConfiguration

## SYNOPSIS
Scans the current subscription for any azure storage accounts that you have access to, and pushes a specific (or first found) connection string to a given Key Vault.

## SYNTAX

```
Set-StorageConfiguration [-VaultName] <String> [[-ResourceGroupFilter] <String>] [[-KeyName] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Does a full subscription scan for all the azure storage accounts and reads, either the first key with full permissions, or a specific key if $KeyName is used, independently of it's permission set.
Support resource group filtering, because most times there are several storage accounts that are not application-bound.
By specifying $KeyName, this script can be used to rotate storage account keys.

## EXAMPLES

### EXAMPLE 1
```
Set-StorageConfiguration my-key-vault
Scans the current subscription for any azure storage accounts that you have access to, and pushes the first key, with full permissions, connection string for each account to the 'my-key-vault' Key Vault.
```

### EXAMPLE 2
```
Set-StorageConfiguration my-key-vault -ResourceGroupFilter 'my-rg'
Scans the current subscription for any azure storage accounts, that are in Resource Groups that -match 'my-rg', and that you have access to, and pushes the first key, with full permissions, connection string for each account to the 'my-key-vault' Key Vault.
```

### EXAMPLE 3
```
Set-StorageConfiguration my-key-vault -ResourceGroupFilter 'my-rg' -KeyName 'key99'
Scans the current subscription for any azure storage accounts, that are in Resource Groups that -match 'my-rg', and that you have access to, and pushes the key named 'key99' connection string for each account to the 'my-key-vault' Key Vault.
If any of the accounts don't have the 'key99' key, it will throw.
```

## PARAMETERS

### -VaultName
The name of the Key Vault that we want to push the connection strings to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupFilter
If present, specifies a regex -match against Resource Group names for the scan.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyName
If present, specifies a specific key to be used to compose the connection string.
If specified and the key isn't found, it will throw.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Assumes you're logged into Azure and in the right subscription.

## RELATED LINKS
