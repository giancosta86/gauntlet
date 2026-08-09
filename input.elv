use str
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq
use ./context

var dual: = (src | context:use-dual-mod)

#
# Reads and trims the string having the given name from the action's input system.
#
# If the string (after trimming) is empty or missing, the function fails - unless &optional is enabled,
# making the function emit just $nil.
#
fn string { |&optional=$false name|
  dual:get-string $name |
    lang:map { |value|
      str:trim-space $value |
        seq:empty-to-default
    } |
    lang:otherwise {
      if $optional {
        put $nil
      } else {
        fail 'Missing input: '$name
      }
    }
}

#
# Reads the number having the given name from the action's input system.
#
# The input string is trimmed before the conversion; if the trimmed string is empty or missing,
# the function fails - unless &optional is enabled, making the function emit just $nil.
#
fn number { |&optional=$false name|
  var string-value = (string &optional=$optional $name)

  lang:map $string-value $num~
}

#
# Reads the boolean having the given name from the action's input system; if present the value must be
# either `true` or `false`.
#
# The input string is trimmed before the conversion; if the trimmed string is empty or missing,
# the function fails - unless &optional is enabled, making the function emit just $nil.
#
fn bool { |&optional=$false name|
  var string-value = (string &optional=$optional $name)

  lang:map $string-value { |value|
    if (eq $value true) {
      put $true
    } elif (eq $value false) {
      put $false
    } else {
      fail 'Invalid bool value for the '''$name''' input: '''$value''''
    }
  }
}

#
# Reads and trims the string having the given name from the action's input system,
# ensuring it belongs to a restricted pool.
#
# If the string (after trimming) is empty or missing, the function fails - unless &optional is enabled,
# making the function emit just $nil.
#
fn enum { |&optional=$false name admissible-list|
  var input-value = (string &optional=$optional $name)

  lang:map $input-value { |value|
    if (not (has-value $admissible-list $value)) {
      fail 'Invalid enum value for the '''$name''' input: '''$value''''
    }

    put $value
  }
}

#
# Reads the string having the given name from the action's input system - and always emits a list.
#
# Splits the items according to the given separator, then trims each of them, discarding empty strings;
# if the input string is missing or empty, emits an empty list.
#
fn list { |&separator=, name|
  var string-value = (string &optional $name)

  lang:map $string-value { |value|
    put [(
      str:split $separator $value |
        each $str:trim-space~ |
        keep-if $seq:is-non-empty~
    )]
  } |
    coalesce (all) []
}
