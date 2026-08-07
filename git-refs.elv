use ./context

var dual: = (src | context:use-dual-mod)

#
# Returns the current Git ref - be it inside or outside of a pull request.
#
var get-current~ = $dual:get-current~