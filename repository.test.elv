use path
use ./tests/fake-context

fake-context:within github {
  use ./repository

  tmp E:GITHUB_REPOSITORY = owner/project-name

  tmp E:GITHUB_WORKSPACE = (path:join / alpha beta)

  >> 'Repository' {
    >> 'getting full name' {
      repository:get-full-name |
        should-be owner/project-name
    }

    >> 'getting name' {
      repository:get-name |
        should-be project-name
    }

    >> 'getting path' {
      >> 'when passing no arguments' {
        repository:get-path |
          should-be (path:join / alpha beta)
      }

      >> 'when passing a single argument' {
        repository:get-path gamma |
          should-be (path:join / alpha beta gamma)
      }

      >> 'when passing two arguments' {
        repository:get-path gamma delta |
          should-be (path:join / alpha beta gamma delta)
      }
    }
  }
}