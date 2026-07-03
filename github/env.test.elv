use ./env

>> 'GitHub' {
  >> 'env' {
    >> 'writing once' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_ENV = $temp-file

        var value = 'Hello, world!'

        env:write alpha $value

        to-lines < $temp-file |
          should-be 'alpha='$value
      }
    }

    >> 'writing multiple values' {
      fs:with-temp-file { |temp-file|
        tmp E:GITHUB_ENV = $temp-file

        env:write alpha Hello
        env:write beta World

        to-lines < $temp-file |
          should-emit [
             'alpha=Hello'
             'beta=World'
          ]
      }
    }
  }
}