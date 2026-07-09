use ./tests/fake-context

fake-context:within github {
  use ./action-references

  >> 'Action references' {
    tmp E:GITHUB_REPOSITORY = owner/my-repo
    tmp E:GITHUB_HEAD_REF = v-fake

    >> 'pointing to other branches' {
      >> 'when missing' {
        fs:with-temp-dir { |temp-dir|
          cd $temp-dir

          {
            echo 'uses: '(get-env GITHUB_REPOSITORY)'/actions/test-action@'(get-env GITHUB_HEAD_REF)
          } > my-action.yaml

          action-references:get-to-other-branches |
            should-be [&]
        }
      }

      >> 'when present' {
        fs:with-temp-dir { |temp-dir|
          cd $temp-dir

          {
            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/test-action@'(get-env GITHUB_HEAD_REF)

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/test-action@some-experimental-version'

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/some-other-action@'(get-env GITHUB_HEAD_REF)

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/some-other-action@ultra-experimental'
          } > alpha.yaml

          mkdir beta

          {
            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/yet-another-action@'(get-env GITHUB_HEAD_REF)

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/my-special-action@giga-experimental'
          } > beta/gamma.yaml

          action-references:get-to-other-branches |
            should-be [
              &alpha.yaml=[
                'uses: owner/my-repo/actions/test-action@some-experimental-version'
                'uses: owner/my-repo/actions/some-other-action@ultra-experimental'
              ]
              &beta/gamma.yaml=[
                'uses: owner/my-repo/actions/my-special-action@giga-experimental'
              ]
            ]
        }
      }
    }
  }
}