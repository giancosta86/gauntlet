use ./tests/fake-context

fake-context:within github {
  use ./branches

  >> 'Detecting the current Git ref' {
    >> 'when not in pull request' {
      tmp E:GITHUB_HEAD_REF = ''

      tmp E:GITHUB_REF = beta

      branches:get-current |
        should-be beta
    }

    >> 'when in pull request' {
      tmp E:GITHUB_HEAD_REF = alpha

      tmp E:GITHUB_REF = beta

      branches:get-current |
        should-be alpha
    }
  }
}