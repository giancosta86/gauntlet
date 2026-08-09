use ./output

>> 'GitHub' {
  >> 'output' {
    >> 'setting a value' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_OUTPUT = $temp-file

        var value = 'Hello, world!'

        output:set alpha $value

        to-lines < $temp-file |
          should-be 'alpha='$value
      }
    }

    >> 'setting multiple values' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_OUTPUT = $temp-file

        output:set alpha Hello
        output:set beta World

        to-lines < $temp-file |
          should-emit [
             alpha=Hello
             beta=World
          ]
      }
    }
  }
}