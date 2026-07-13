use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./context

var output: = (src | context:use-dual-mod)
var values: = (context:use-mod values)

fn set { |key value|
  values:elvish-to-context $value |
    output:set $key (all)
}

fn map { |@arguments|
  lang:get-single-input $arguments |
    map:iterate $set~
}