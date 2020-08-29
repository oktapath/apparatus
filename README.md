# apparatus

Azure PowerShell utility functions built over time as we deliver DevOps projects.

## Functions in the module

### Configuration Management

#### [Set-CosmosConfiguration](./docs/Set-CosmosConfiguration.md)

Does a full subscription scan for all the cosmos databases and reads both read and write keys to compose all the available connection strings.
Can be set to use the secondary keys instead of the primary keys using the -SecondaryKeys switch.

#### [Set-StorageConfiguration](./docs/Set-StorageConfiguration.md)

Does a full subscription scan for all the azure storage accounts and reads, either the first key with full permissions, or a specific key if $KeyName is used, independently of it's permission set.
Support resource group filtering, because most times there are several storage accounts that are not application-bound.
By specifying $KeyName, this script can be used to rotate storage account keys.

### Git

#### [New-PullRequest](./docs/New-PullRequest.md)

Creates a new pull request for the current branch against master.

### Security

#### [Get-MyUserObjectId](./docs/Get-MyUserObjectId.md)

Gets my user Object ID from the current AAD tenant.

#### [Initialize-SubscriptionRbac](./docs/Initialize-SubscriptionRbac.md)

Cleans up RBAC for a given subscription.

