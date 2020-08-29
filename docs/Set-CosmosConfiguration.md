---
external help file: Apparatus-help.xml
Module Name: Apparatus
online version:
schema: 2.0.0
---

# Set-CosmosConfiguration

## SYNOPSIS
Scans the current subscription for any cosmos db accounts that you have access to, and pushes their read and write connection strings to a given Key Vault.

## SYNTAX

```
Set-CosmosConfiguration [-VaultName] <String> [-SecondaryKeys] [<CommonParameters>]
```

## DESCRIPTION
Does a full subscription scan for all the cosmos databases and reads both read and write keys to compose all the available connection strings.
Can be set to use the secondary keys instead of the primary keys using the -SecondaryKeys switch.

## EXAMPLES

### EXAMPLE 1
```
Set-CosmosConfiguration my-key-vault
Scans the current subscription for any cosmos db accounts that you have access to, and pushes their read and write connection strings to the 'my-key-vault' Key Vault.
```

### EXAMPLE 2
```
Set-CosmosConfiguration my-key-vault -SecondaryKeys
Scans the current subscription for any cosmos db accounts that you have access to, and pushes their read and write connection strings, using the secondary keys, to the 'my-key-vault' Key Vault.
```

## PARAMETERS

### -VaultName
The name of the Key Vault that we want to push the connection strings to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecondaryKeys
\[SWITCH\] If present, it will use the secondary keys instead of the primary keys to compose the connection string.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
