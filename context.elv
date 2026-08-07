use builtin
use path
use github.com/giancosta86/ethereal/v1/fs
use github.com/giancosta86/ethereal/v1/lang

#
# Returns the code of the current CI/CD system, or $nil if none was detected.
#
# Supported codes:
#
# * github
#
fn detect {
  if (eq $E:GITHUB_ACTIONS true) {
    put github
  } else {
    put $nil
  }
}

#
# Loads and emits the module with the given name from the subdirectory
# related to the current CI/CD architecture: if none was detected,
# the function fails.
#
fn use-mod { |@arguments|
  var module-name = (lang:get-single-input $arguments)

  var context = (detect)

  if (not $context) {
    fail 'Cannot detect the CI/CD context!'
  }

  builtin:use-mod './'$context'/'$module-name
}

#
# Given in input the result of the `src` function,
# loads and emits the module having the very same name, but located
# in the subdirectory related to the current CI/CD architecture.
#
# If no architecture is detected, the function fails.
#
fn use-dual-mod { |@arguments|
  var src-result = (lang:get-single-input $arguments)

  put $src-result[name] |
    path:base (all) |
    fs:split-ext |
    take 1 |
    use-mod
}