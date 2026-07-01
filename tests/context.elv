fn set { |context|
  unset-env GITHUB_ACTIONS

  if (not $context) {
    return
  } elif (eq $context github) {
    set-env GITHUB_ACTIONS true
  } else {
    fail 'Unsupported context: '$context
  }
}