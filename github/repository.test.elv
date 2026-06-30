use ./repository

>> 'GitHub' {
  >> 'repository' {
    var full-repository-name = 'owner/project-name'

    tmp E:GITHUB_REPOSITORY = $full-repository-name

    >> 'getting full name' {
      repository:get-full-name |
        should-be $full-repository-name
    }

    >> 'getting name' {
      repository:get-name |
        should-be project-name
    }
  }
}