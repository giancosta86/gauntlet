use ./fake-context

>> 'Fake context' {
  >> 'simulation block' {
    >> 'when requesting no context' {
      >> 'should hide an existing GitHub context during execution' {
        tmp E:GITHUB_ACTIONS = true

        fake-context:within $nil {
          has-env GITHUB_ACTIONS |
            should-be $false
        }
      }

      >> 'should restore an existing GitHub context before ending' {
        tmp E:GITHUB_ACTIONS = true

        fake-context:within $nil { }

        get-env GITHUB_ACTIONS |
          should-be true
      }
    }

    >> 'when requesting a GitHub context' {
      >> 'should actually provide it' {
        tmp E:GITHUB_ACTIONS = false

        fake-context:within github {
          get-env GITHUB_ACTIONS |
            should-be true
        }
      }

      >> 'should not alter an existing GitHub context' {
        tmp E:GITHUB_ACTIONS = true

        fake-context:within github { }

        get-env GITHUB_ACTIONS |
          should-be true
      }
    }
  }
}