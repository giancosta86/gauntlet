use ./context
use ./tests/fake-context

>> 'Context' {
  >> 'detection' {
    >> 'when the context is not defined' {
      fake-context:within $nil {
        context:detect |
          should-be $nil
      }
    }

    >> 'when the context is defined' {
      fake-context:within github {
        context:detect |
          should-be github
      }
    }
  }

  >> 'loading a context-based module' {
    >> 'when the context is not defined' {
      fake-context:within $nil {
        fails {
          context:use-mod repository
        } |
          should-be 'Cannot detect the CI/CD context!'
      }
    }

    >> 'when the context is defined' {
      fake-context:within github {
        tmp E:GITHUB_REPOSITORY = giancosta86/gauntlet

        var repository-module: = (context:use-mod repository)

        repository-module:get-name |
          should-be gauntlet
      }
    }
  }
}