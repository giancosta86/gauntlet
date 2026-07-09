use github.com/giancosta86/ethereal/v1/seq
use ./context

var action-references: = (src | context:use-dual-mod)

fn get-to-other-branches {
  put **.yaml |
    seq:reduce [&] { |references-by-map source-path|
      var other-references = [(action-references:get-to-other-branches $source-path)]

      if (seq:is-non-empty $other-references) {
        assoc $references-by-map $source-path $other-references
      } else {
        put $references-by-map
      }
    }
}