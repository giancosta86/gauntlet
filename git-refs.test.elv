use ./tests/fake-context

fake-context:within github {
  use ./git-refs

  tmp E:GITHUB_HEAD_REF = my-branch

  >> 'Detecting the current Git ref' {
    git-refs:get-current |
      should-be my-branch
  }
}