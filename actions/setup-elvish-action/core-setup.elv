use epm
use os
use path
use str

var core-repository = (get-env core-repository)
var core-directory = (get-env core-directory)

if (eq $core-directory '') {
  echo 💭 core directory not declared...
} else {
  if (not (os:is-dir $core-directory)) {
    fail 'Missing core directory: '$core-directory
  }

  if (eq $core-repository '') {
    fail 'core-repository input missing!'
  }

  var package-reference = (
    str:join / [
      github.com
      $core-repository
    ]
  )

  var link-path = (
    path:join $epm:managed-dir $package-reference
  )

  if (not (os:exists $link-path)) {
    path:dir $link-path |
      os:mkdir-all (all)

    var link-source = (path:abs $core-directory)

    os:symlink $link-source $link-path

    echo 🧬 The package reference ''''$package-reference'''' now points to core directory: ''''$link-source''''
  }
}