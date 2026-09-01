use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/map
use ./context

var dual: = (src | context:use-dual-mod)
var values: = (context:use-mod values)

#
# Sets a single variable in the workflow environment.
#
fn set { |key @arguments|
  var value = (lang:get-single-input $arguments)

  var context-value = (values:elvish-to-context $value)

  # This ensures that the rest of the current action can access the value
  set-env $key $context-value

  # This ensures the values is persisted all over the workflow
  dual:set $key $context-value
}

#
# Maps multiple variables in the workflow environment.
#
fn map { |@arguments|
  lang:get-single-input $arguments |
    map:iterate $set~
}

#
# If the given environment variable exists in the current step,
# propagate it to downstream steps.
#
fn cascade { |@arguments|
  var var-name = (lang:get-single-input $arguments)

  if (has-env $var-name) {
    get-env $var-name |
      $set~ $var-name (all)
  }
}