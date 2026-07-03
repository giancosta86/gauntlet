use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./context

var env: = (context:use-mod env)
var values: = (context:use-mod values)

fn write { |key value|
  var context-value = (values:elvish-to-context $value)

  set-env $key $context-value

  env:write $key $context-value
}

fn map { |@arguments|
  lang:get-single-input $arguments |
    map:iterate $write~
}