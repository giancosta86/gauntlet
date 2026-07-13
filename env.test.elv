use ./tests/fake-context

fake-context:within github {
  use ./env

  >> 'Env' {
    >> 'writing a value' {
      fs:with-temp-file { |temp-file|
        set-env GITHUB_ENV $temp-file

        put $true |
          env:set alpha

        >> 'should update the environment variable' {
          get-env alpha |
            should-be true
        }

        >> 'should persist the change for downstream' {
          to-lines < $temp-file |
            should-be alpha=true
        }
      }
    }

    >> 'mapping values' {
      fs:with-temp-file { |temp-file|
        set-env GITHUB_ENV $temp-file

        env:map [
          &alpha=$false
          &beta=(num 98)
        ]

        >> 'should update the environment variables' {
          get-env alpha |
            should-be false

          get-env beta |
            should-be 98
        }

        >> 'should persist the changes for downstream' {
          to-lines < $temp-file |
            should-emit &any-order [
              alpha=false
              beta=98
            ]
        }
      }
    }
  }
}