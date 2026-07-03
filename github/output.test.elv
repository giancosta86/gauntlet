use ./output

>> 'GitHub' {
  >> 'output' {
    >> 'writing once' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_OUTPUT = $temp-file

        var value = 'Hello, world!'

        output:write alpha $value

        to-lines < $temp-file |
          should-be 'alpha='$value
      }
    }

    >> 'writing multiple values' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_OUTPUT = $temp-file

        output:write alpha Hello
        output:write beta World

        to-lines < $temp-file |
          should-emit [
             'alpha=Hello'
             'beta=World'
          ]
      }
    }
  }
}