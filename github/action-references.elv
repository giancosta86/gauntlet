use re
use str
use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq
use ./git-refs
use ./repository

fn -is-reference-to-other-branch { |line|
  var full-repository-name = (repository:get-full-name)

  var reference-regex = 'uses:\s+'$full-repository-name'/[^@]+@(.+)$'

  var reference-branch = (
    re:find $reference-regex $line |
      lang:ensure-put |
      lang:map { |match|
        put $match[groups][1][text]
      }
  )

  var current-branch = (git-refs:get-current)

  not-eq $reference-branch $current-branch
}

fn get-to-other-branches { |@arguments|
  var source-path = (lang:get-single-input $arguments)

  to-lines < $source-path |
    keep-if $seq:is-non-empty~ |
    keep-if $-is-reference-to-other-branch~ |
    each $str:trim-space~
}