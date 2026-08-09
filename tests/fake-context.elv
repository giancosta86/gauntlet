use ../context

fn -unset-all-contexts {
  unset-env GITHUB_ACTIONS
}

fn -set-github-context {
  set-env GITHUB_ACTIONS true
}

fn -set-context { |context|
  -unset-all-contexts

  if (not $context) {
    # Just do nothing
  } elif (eq $context github) {
    -set-github-context
  } else {
    fail 'Unsupported context for tests: '$context
  }
}

fn within { |context block|
  var previous-context = (context:detect)

  try {
    -set-context $context

    $block
  } finally {
    -set-context $previous-context
  }
}