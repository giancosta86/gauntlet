use ./pull-request

>> 'GitHub' {
  >> 'pull request' {
    >> 'getting the branch' {
      >> 'when not in a pull request' {
        tmp E:GITHUB_HEAD_REF = ''

        pull-request:get-branch |
          should-be ''
      }

      >> 'when in a pull request' {
        tmp E:GITHUB_HEAD_REF = 'dodo'

        pull-request:get-branch |
          should-be dodo
      }
    }
  }
}