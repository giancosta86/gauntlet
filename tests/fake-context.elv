use ../context

fn -unset-all-contexts {
  unset-env GITHUB_ACTIONS
}

fn -set-github-context {
  set-env GITHUB_ACTIONS true
}

fn within { |context block|
  var previous-context = (context:detect)

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