use ./action-references

>> 'GitHub' {
  >> 'action references' {
    tmp E:GITHUB_REPOSITORY = owner/my-repo
    tmp E:GITHUB_HEAD_REF = v-fake

    >> 'pointing to other branches' {
      >> 'when missing' {
        fs:with-temp-file { |temp-file|
          {
            echo 'uses: '(get-env GITHUB_REPOSITORY)'/actions/test-action@'(get-env GITHUB_HEAD_REF)
          } > $temp-file

          action-references:get-to-other-branches $temp-file |
            should-emit []
        }
      }

      >> 'when present' {
        fs:with-temp-file { |temp-file|
          {
            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/test-action@'(get-env GITHUB_HEAD_REF)

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/test-action@some-experimental-version'

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/some-other-action@'(get-env GITHUB_HEAD_REF)

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/some-other-action@ultra-experimental'
          } > $temp-file

          action-references:get-to-other-branches $temp-file |
            should-emit [
              'uses: '(get-env GITHUB_REPOSITORY)'/actions/test-action@some-experimental-version'

              'uses: '(get-env GITHUB_REPOSITORY)'/actions/some-other-action@ultra-experimental'
            ]
        }
      }
    }
  }
}