use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./context

var output: = (context:use-mod output)
var values: = (context:use-mod value)

fn write { |key value|
  values:elvish-to-context $value |
    env:write $key (all)
}

fn map { |@arguments|
  lang:get-single-input $arguments |
    map:iterate $source-map $write~
}