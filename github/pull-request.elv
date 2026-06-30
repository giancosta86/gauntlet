fn get-branch {
  if (has-env GITHUB_HEAD_REF) {
    get-env GITHUB_HEAD_REF
  } else {
    put ''
  }
}