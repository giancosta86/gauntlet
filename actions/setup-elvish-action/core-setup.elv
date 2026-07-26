use epm
use os
use path
use str

var core-directory = (get-env core-directory)

if (os:is-dir $core-directory) {
  var package-reference = (
    str:join / [
      github.com
      (get-env GITHUB_REPOSITORY)
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