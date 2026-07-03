use ./context

pragma unknown-command = disallow

var action-references: = (context:use-mod action-references)

var grep~ = (external grep)

fn find-to-other-branches {
  var regex = (action-references:get-regex-for-references-to-other-branches $branch)

  var grep-outcome = ?(
    grep --color=always --perl-regexp $regex **.yml > &2
  )

  eq $grep-outcome $ok
}