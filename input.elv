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
      fail 'Invalid enum value for the '''$name''' input: '''$value''''
    }

    put $value
  }
}

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
