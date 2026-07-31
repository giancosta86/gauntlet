use ./tests/fake-context

fake-context:within github {
  >> 'Pull request' {
    >> 'should be importable' {
      run-dual (src)
    }
  }
}