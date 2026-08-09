use ./context

var dual: = (src | context:use-dual-mod)

#
# Emits the branch of the current pull request; otherwise, emits $nil.
#
var get-branch~ = $dual:get-branch~
