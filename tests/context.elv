use ../gauntlet

fn -unset-all-contexts {
  unset-env GITHUB_ACTIONS
}

fn -set-github-context {
  set-env GITHUB_ACTIONS true
}

fn within { |context block|
  var previous-context = (gauntlet:get-context)

  -unset-all-contexts

  try {
    if (not $context) {
      # Just do nothing
    } elif (eq $context github) {
      -set-github-context
    } else {
      fail 'Unsupported context in tests: '$context
    }

    $block
  } finally {
    if (eq $previous-context github) {
      -set-github-context
    }
  }
}