use ./tests/fake-context

fake-context:within github {
  use ./output

  >> 'Output' {
    >> 'writing a value' {
      fs:with-temp-file { |temp-file|
        set-env GITHUB_OUTPUT $temp-file

        put $true |
          output:set alpha

        to-lines < $temp-file |
          should-be alpha=true
      }
    }

    >> 'mapping values' {
      fs:with-temp-file { |temp-file|
        set-env GITHUB_OUTPUT $temp-file

        output:map [
          &alpha=$true
          &beta=(num 90)
          &gamma=Hello
        ]

        to-lines < $temp-file |
          should-emit &any-order [
            alpha=true
            beta=90
            gamma=Hello
          ]
      }
    }
  }
}