use github.com/giancosta86/ethereal/v1/lang

var -constant-mappings = [
  &$nil=''
  &$true='true'
  &$false='false'
]

fn elvish-to-context { |@arguments|
  var value = (lang:get-single-input $arguments )

  lang:get-value $-constant-mappings $value |
    lang:otherwise {
      to-string $value
    }
}