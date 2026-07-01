use ./input

>> 'GitHub' {
  >> 'input' {
    >> 'when the env var is not set' {
      input:get-string some-very-unusual-environment-variable-name |
        should-be $nil
    }

    >> 'when the env var is set' {
      tmp E:dodo = 'Hello, world!'

      input:get-string dodo |
        should-be (get-env dodo)
    }
  }
}