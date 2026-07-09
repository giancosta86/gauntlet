use github.com/giancosta86/ethereal/v1/resources
use ./context
use ./tests/fake-context

var resources = (src | resources:for-script)

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

  >> 'loading a dual module' {
    fake-context:within github {
      var fake-src = [
        &name=($resources[get-path] action-references.elv)
      ]

      var dual-module = (context:use-dual-mod $fake-src)

      has-key $dual-module get-to-other-branches~ |
        should-be $true
    }
  }
}