use ./tests/fake-context

fake-context:within github {
  >> 'Artifact release' {
    >> 'should be importable' {
      run-dual (src)
    }
  }
}