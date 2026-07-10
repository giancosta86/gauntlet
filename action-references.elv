use github.com/giancosta86/ethereal/v1/lang
use ./context

var action-references: = (src | context:use-dual-mod)
var git-refs: = (src | context:use-mod git-refs)
var repository: = (src | context:use-mod repository)

fn get-to-other-branches { |&colors=$false|
  var full-repository-name = (repository:get-full-name)

  var current-branch = (git-refs:get-current)

  var regex = (action-references:get-perl-regex-to-other-branches $full-repository-name $current-branch)

  try {
    var color-arg = (lang:ternary $colors always never)

    var grep-lines = [(
      grep --color=$color-arg --perl-regexp --with-filename --line-number $regex --recursive --include='*.yml'
    )]

    all $grep-lines
  } catch e {
    if (!= $e[reason][exit-status] 1) {
      fail $e
    }
  }
}