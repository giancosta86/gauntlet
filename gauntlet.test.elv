use ./gauntlet
use ./tests/context

>> 'Getting the context' {
  >> 'when the context is not defined' {
    context:within $nil {
      gauntlet:get-context |
        should-be $nil
    }
  }

  >> 'when the context is defined' {
    context:within github {
      gauntlet:get-context |
        should-be github
    }
  }
}


>> 'Loading a context-based module' {
  >> 'when the context is not defined' {
    context:within $nil {
      fails {
        gauntlet:load-context-module repository
      } |
        should-be 'Cannot detect the CI/CD context!'
    }
  }

  >> 'when the context is defined' {
    context:within github {
      tmp E:GITHUB_REPOSITORY = giancosta86/gauntlet

      var repository-module: = (gauntlet:load-context-module repository)

      repository-module:get-name |
        should-be gauntlet
    }
  }
}