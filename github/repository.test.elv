use path
use ./repository

>> 'GitHub' {
  >> 'repository' {
    var full-repository-name = 'owner/project-name'

    tmp E:GITHUB_REPOSITORY = $full-repository-name
    tmp E:GITHUB_WORKSPACE = (path:join / alpha beta)

    >> 'getting full name' {
      repository:get-full-name |
        should-be $full-repository-name
    }

    >> 'getting name' {
      repository:get-name |
        should-be project-name
    }

    >> 'getting root directory' {
      repository:get-root-directory |
        should-be (path:join / alpha beta)
    }
  }
}