use ./tests/fake-context

fake-context:within github {
  use ./action-references

  >> 'Action references' {
    tmp E:GITHUB_REPOSITORY = owner/my-repo
    tmp E:GITHUB_HEAD_REF = v-fake

    >> 'pointing to other branches' {
      >> 'when no file exists' {
        fs:with-temp-dir { |temp-dir|
          cd $temp-dir

          action-references:get-to-other-branches |
            should-emit []
        }
      }

      >> 'when missing' {
        fs:with-temp-dir { |temp-dir|
          cd $temp-dir

          {
            echo 'uses: '(get-env GITHUB_REPOSITORY)'/actions/test-action@'(get-env GITHUB_HEAD_REF)
          } > my-action.yml

          action-references:get-to-other-branches |
            should-emit []
        }
      }

      >> 'when present' {
        fs:with-temp-dir { |temp-dir|
          cd $temp-dir

          {
            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/test-action@'(get-env GITHUB_HEAD_REF)

            echo "uses: "(get-env GITHUB_REPOSITORY)'/actions/test-action@some-experimental-version'

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/some-other-action@'(get-env GITHUB_HEAD_REF)

            echo "\tuses: "(get-env GITHUB_REPOSITORY)'/actions/some-other-action@ultra-experimental'
          } > alpha.yml

          mkdir beta

          {
            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/yet-another-action@'(get-env GITHUB_HEAD_REF)

            echo "\t\tuses: "(get-env GITHUB_REPOSITORY)'/actions/my-special-action@giga-experimental'
          } > beta/gamma.yml

          action-references:get-to-other-branches |
            should-emit &any-order [
              "beta/gamma.yml:2:\t\tuses: owner/my-repo/actions/my-special-action@giga-experimental"
              "alpha.yml:2:uses: owner/my-repo/actions/test-action@some-experimental-version"
              "alpha.yml:4:\tuses: owner/my-repo/actions/some-other-action@ultra-experimental"
            ]
        }
      }
    }
  }
}