use github.com/giancosta86/ethereal/v1/command
use ../github/release

fn apply { |block|
  var spy = (command:spy)

  tmp release:-gh~ = $spy[command]

  $block $spy
}