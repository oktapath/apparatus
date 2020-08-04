---
external help file: DevOps.Flex-help.xml
Module Name: DevOps.Flex
online version:
schema: 2.0.0
---

# Get-MyUserObjectId

## SYNOPSIS
Gets my user Object ID from the current AAD tenant.

## SYNTAX

```
Get-MyUserObjectId [<CommonParameters>]
```

## DESCRIPTION
Gets my user Object ID from the current AAD tenant.
If I'm a delegated guest in the current AAD tenant it will return the Object ID for the delegation, not the original account from the original tenant.

## EXAMPLES

### EXAMPLE 1
```
Get-MyUserObjectId
Gets my user Object ID from the current AAD tenant.
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
