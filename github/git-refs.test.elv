use ./git-refs

>> 'GitHub' {
  >> 'Git references' {
    >> 'when not in pull request' {
      tmp E:GITHUB_HEAD_REF = ''

      tmp E:GITHUB_REF = beta

      git-refs:get-current |
        should-be beta
    }

    >> 'when in pull request' {
      tmp E:GITHUB_HEAD_REF = alpha

      tmp E:GITHUB_REF = beta

      git-refs:get-current |
        should-be alpha
    }
  }
}