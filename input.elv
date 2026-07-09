use os
use path
use str
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq
use ./context

var input: = (src | context:use-dual-mod)

fn string { |&optional=$false name|
  input:get-string $name |
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

fn number { |&optional=$false name|
  var string-value = (string &optional=$optional $name)

  lang:map $string-value $num~
}

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

fn enum { |&optional=$false name admissible-list|
  var string-value = (string &optional=$optional $name)

  lang:map $string-value { |value|
    if (not (has-value $admissible-list $value)) {
      fail 'Invalid enum value for the '''$name''' input: '''$value'''!'
    }

    put $value
  }
}

fn list { |&separator=, name|
  var string-value = (string &optional $name)

  if $string-value {
    put [(
      str:split $separator $string-value |
        each $str:trim-space~ |
        keep-if $seq:is-non-empty~
    )]
  } else {
    put []
  }
}

fn -file-system-input { |&optional=$false &can-be-missing=$false type-description name path-checker|
  var string-value = (string &optional=$optional $name)

  lang:map $string-value { |value|
      var abs-path = (
        path:abs $value
      )

      if (or $can-be-missing ($path-checker $abs-path)) {
        put $abs-path
      } else {
        fail 'Inexistent '$type-description' for input '''$name''' at path: '''$abs-path'''!'
      }
    }
}

fn directory { |&optional=$false &can-be-missing=$false name|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing directory $name $os:is-dir~
}

fn file { |&optional=$false &can-be-missing=$false name|
  -file-system-input &optional=$optional &can-be-missing=$can-be-missing file $name $os:is-regular~
}