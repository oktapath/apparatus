function Initialize-SubscriptionRbac
{
<#

.SYNOPSIS
Cleans up RBAC for a given subscription.

.DESCRIPTION
Removes every user from a single RoleDefinition by name into a specific AAD group so that assignment can be done to the group instead of to several people.

.PARAMETER AdGroup
The ADGroup that we want to add the specific role to.

.PARAMETER RoleDefinitionName
The Name of the role definition that we are about to cleanup.

.EXAMPLE
Get-AzADGroup -DisplayName 'Developers' | Initialize-SubscriptionRbac -RoleDefinitionName 'Contributor'
Will move all users from being contributors in the subscription into the Developers AAD group so that the contributor role can later be assigned to the group.

#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [Microsoft.Azure.Commands.ActiveDirectory.PSADGroup] $AdGroup,

        [Parameter(Mandatory=$true, Position=1)]
        [string] $RoleDefinitionName
    )

    $contributors = Get-AzRoleAssignment | Where-Object {
        $_.ObjectType -match 'User' -and $_.RoleDefinitionName -match $RoleDefinitionName
    }

    $contributors | ForEach-Object {
        $AdGroup | Add-AzADGroupMember -MemberObjectId $_.ObjectId -ErrorAction Continue
        Remove-AzRoleAssignment -ObjectId $_.ObjectId -RoleDefinitionName $RoleDefinitionName
    }
}