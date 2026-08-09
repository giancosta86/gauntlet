use ./values

>> 'GitHub' {
  >> 'converting Elvish value to context value' {
    >> 'when the value is nil' {
      values:elvish-to-context $nil |
        should-be &strict ''
    }

    >> 'when the value is a string' {
      values:elvish-to-context dodo |
        should-be &strict dodo
    }

    >> 'when the value is a number' {
      values:elvish-to-context (num 90) |
        should-be &strict 90
    }

    >> 'when the value is a boolean' {
      values:elvish-to-context $true |
        should-be &strict true

      values:elvish-to-context $false |
        should-be &strict false
    }

    >> 'when the value is a list' {
      put [
        90
        92
        95
        98
      ] |
        values:elvish-to-context |
        should-be &strict '[90 92 95 98]'
    }

    >> 'when the value is a map' {
      put [
        &a=90
      ] |
        values:elvish-to-context |
        should-be &strict '[&a=90]'
    }
  }
}