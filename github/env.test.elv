use ./env

>> 'GitHub' {
  >> 'env' {
    >> 'writing once' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_ENV = $temp-file

        var value = 'Hello, world!'

        env:set alpha $value

        to-lines < $temp-file |
          should-be 'alpha='$value
      }
    }

    >> 'writing multiple values' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_ENV = $temp-file

        env:set alpha Hello
        env:set beta World

        to-lines < $temp-file |
          should-emit [
            alpha=Hello
            beta=World
          ]
      }
    }
  }
}