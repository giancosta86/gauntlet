use builtin

fn detect {
  if (eq $E:GITHUB_ACTIONS true) {
    put github
  } else {
    put $nil
  }
}

fn use-mod { |module-name|
  var context = (detect)

  if (not $context) {
    fail 'Cannot detect the CI/CD context!'
  }

  builtin:use-mod './'$context'/'$module-name
}