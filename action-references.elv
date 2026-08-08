use github.com/giancosta86/ethereal/v1/lang
use ./context

var dual: = (src | context:use-dual-mod)

var branches: = (context:use-mod branches)

var repository: = (context:use-mod repository)

#
# After scanning all the .yml files below the current directory,
# emits all the references pointing to other actions that belong to this repository but have a different version.
#
fn get-to-other-branches { |&colors=$false|
  var full-repository-name = (repository:get-full-name)

  var current-branch = (branches:get-current)

  var regex = (dual:get-perl-regex-to-other-branches $full-repository-name $current-branch)

  try {
    var color-arg = (lang:ternary $colors always never)

    var grep-lines = [(
      grep --color=$color-arg --perl-regexp --with-filename --line-number $regex --recursive --include='*.yml'
    )]

    all $grep-lines
  } catch e {
    var grep-error-occurred = (== $e[reason][exit-status] 2)

    if $grep-error-occurred {
      fail $e
    }
  }
}