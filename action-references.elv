#TODO! Here, load action-references for the specific CI/CD

pragma unknown-command = disallow

var grep~ = (external grep)

fn find-in-other-branches {
  var regex = (action-references:get-regex-for-references-to-other-branches $branch)

  var grep-outcome = ?(
    grep --color=always --perl-regexp $regex **.yml > &2
  )

  eq $grep-outcome $ok
}