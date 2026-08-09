use path
use ./context

var dual: = (src | context:use-dual-mod)

#
# Returns the full name of the current repository.
#
# For example, `giancosta86/ethereal`.
#
var get-full-name~ = $dual:get-full-name~

# Returns the main name of the current repository.
#
# For example, `ethereal`.
#
var get-name~ = $dual:get-name~

#
# Passed without arguments, returns the root directory of the current repository;
# for any additional argument, appends it as a path component.
#
fn get-path { |@sub-path-components|
  var root-directory = (dual:get-root-dir)

  path:join $root-directory $@sub-path-components
}