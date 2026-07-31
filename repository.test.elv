use ./tests/fake-context

fake-context:within github {
  >> 'Repository' {
    >> 'should be importable' {
      run-dual (src)
    }
  }
}