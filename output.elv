use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./context

var dual: = (src | context:use-dual-mod)
var values: = (context:use-mod values)

#
# Sets a single value in the key-value pairs of the current action.
#
fn set { |key @arguments|
  var value = (lang:get-single-input $arguments)

  values:elvish-to-context $value |
    dual:set $key (all)
}

#
# Sets multiple key-value pairs in the output of the current action.
#
fn map { |@arguments|
  lang:get-single-input $arguments |
    map:iterate $set~
}