use epm
use os
use path
use str

var core-package = (get-env core-package)
var core-directory = (get-env core-directory)

if (eq $core-package '') {
  echo 💭 core package not declared...
} else {
  if (not (os:is-dir $core-directory)) {
    fail 'Missing core directory: '$core-directory
  }

  var link-path = (
    path:join $epm:managed-dir $core-package
  )

  if (os:exists $link-path) {
    echo 🔗 Core link "'"$link-path"'" already exists...
  } else {
    path:dir $link-path |
      os:mkdir-all (all)

    var link-source = (path:abs $core-directory)

    os:symlink $link-source $link-path

    echo 🧬 Package ''''$core-package'''' now points to core directory: ''''$link-source''''
  }
}