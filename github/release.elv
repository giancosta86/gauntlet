use github.com/giancosta86/ethereal/v1/lang
use github.com/giancosta86/ethereal/v1/seq

pragma unknown-command = disallow

var -gh~ = (external gh)

fn create-draft { |tag title|
  -gh release create $tag --draft --title $title --generate-notes
}

fn upload-artifacts { |&overwrite=$false release-tag @files|
  if (seq:is-empty $files) {
    fail 'No files declared!'
  }

  var clobber-arg = (lang:ternary $overwrite [--clobber] [])

  -gh release upload $@clobber-arg $release-tag $@files
}
