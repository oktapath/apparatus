function New-PullRequest
{
<#

.SYNOPSIS
Creates a new pull request for the current branch against master.

.DESCRIPTION
Creates a new pull request for the current branch against master.

.EXAMPLE
New-PullRequest
Creates a new pull request for the current branch against master.

#>

    $branch = git branch --show-current
    $repo = git config --get remote.origin.url

    start "$repo/pullrequestcreate?sourceRef=$branch&targetRef=master"
}