use github.com/giancosta86/ethereal/v1/lang
use ./pull-request

fn get-current {
  pull-request:get-branch |
    lang:otherwise {
      get-env GITHUB_REF
    }
}
