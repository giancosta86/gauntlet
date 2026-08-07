use github.com/giancosta86/ethereal/v1/seq

fn get-branch {
  seq:empty-to-default $E:GITHUB_HEAD_REF
}