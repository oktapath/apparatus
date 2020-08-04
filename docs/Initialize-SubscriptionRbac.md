---
external help file: DevOps.Flex-help.xml
Module Name: DevOps.Flex
online version:
schema: 2.0.0
---

# Initialize-SubscriptionRbac

## SYNOPSIS
Cleans up RBAC for a given subscription.

## SYNTAX

```
Initialize-SubscriptionRbac -AdGroup <PSADGroup> [-RoleDefinitionName] <String> [<CommonParameters>]
```

## DESCRIPTION
Removes every user from a single RoleDefinition by name into a specific AAD group so that assignment can be done to the group instead of to several people.

## EXAMPLES

### EXAMPLE 1
```
Get-AzADGroup -DisplayName 'Developers' | Initialize-SubscriptionRbac -RoleDefinitionName 'Contributor'
Will move all users from being contributors in the subscription into the Developers AAD group so that the contributor role can later be assigned to the group.
```

## PARAMETERS

### -AdGroup
The ADGroup that we want to add the specific role to.

```yaml
Type: PSADGroup
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RoleDefinitionName
The Name of the role definition that we are about to cleanup.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
