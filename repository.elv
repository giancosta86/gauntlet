use path
use ./context

var repository: = (context:use-mod repository)

var get-full-name~ = $repository:get-full-name~

var get-name~ = $repository:get-name~

fn get-path { |@sub-path-components|
  var root-directory = (repository:get-root-directory)

  path:join $root-directory $@sub-path-components
}