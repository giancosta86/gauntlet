use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./context

var env: = (src | context:use-dual-mod)
var values: = (context:use-mod values)

fn set { |key @arguments|
  var value = (lang:get-single-input $arguments)

  var context-value = (values:elvish-to-context $value)

  set-env $key $context-value

  env:set $key $context-value
}

fn map { |@arguments|
  lang:get-single-input $arguments |
    map:iterate $set~
}