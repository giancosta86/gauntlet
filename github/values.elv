use github.com/giancosta86/ethereal/v1/lang

var -elvish-to-context-mappings = [
  &$nil=''
  &$true='true'
  &$false='false'
]

fn elvish-to-context { |@arguments|
  var value = (lang:get-single-input $arguments )

  lang:get-value $-elvish-to-context-mappings $value |
    lang:otherwise {
      to-string $value
    }
}