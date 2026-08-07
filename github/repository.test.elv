use path
use ./repository

>> 'GitHub' {
  >> 'repository' {
    tmp E:GITHUB_REPOSITORY = owner/project-name

    tmp E:GITHUB_WORKSPACE = (path:join / alpha beta)

    >> 'getting full name' {
      repository:get-full-name |
        should-be owner/project-name
    }

    >> 'getting name' {
      repository:get-name |
        should-be project-name
    }

    >> 'getting root directory' {
      repository:get-root-dir |
        should-be (path:join / alpha beta)
    }
  }
}