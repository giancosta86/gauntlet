use builtin
use path
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/lang

fn detect {
  if (eq $E:GITHUB_ACTIONS true) {
    put github
  } else {
    put $nil
  }
}

fn use-mod { |@arguments|
  var module-name = (lang:get-single-input $arguments)

  var context = (detect)

  if (not $context) {
    fail 'Cannot detect the CI/CD context!'
  }

  builtin:use-mod './'$context'/'$module-name
}

fn use-dual-mod { |@arguments|
  var src-result = (lang:get-single-input $arguments)

  put $src-result[name] |
    path:base (all) |
    fs:split-ext |
    take 1 |
    use-mod
}