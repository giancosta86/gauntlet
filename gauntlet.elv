fn get-context {
  if (eq $E:GITHUB_ACTIONS true) {
    put github
  } else {
    put $nil
  }
}

fn load-context-module { |module-name|
  var context = (get-context)

  if (not $context) {
    fail 'Cannot detect the CI/CD context!'
  }

  use-mod './'$context'/'$module-name
}