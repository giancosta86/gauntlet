use ./action-references

>> 'GitHub' {
  >> 'action references' {
    tmp E:GITHUB_REPOSITORY = owner/my-repo

    >> 'getting regex for reference to other branches' {
      action-references:get-regex-for-references-to-other-branches v12 |
        should-be 'uses:\s*owner/my-repo/[^@]+@(?!v12)'
    }
  }
}