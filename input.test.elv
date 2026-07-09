use ./tests/fake-context

fake-context:within github {
  use ./input

  >> 'Input' {
    >> 'string' {
      >> 'when the input is missing' {
        >> 'when mandatory' {
          fails {
            input:string SOME-INEXISTING-VAR
          } |
            should-be 'Missing input: SOME-INEXISTING-VAR'
        }

        >> 'when optional' {
          input:string &optional SOME-INEXISTING-VAR |
            should-be $nil
        }
      }

      >> 'when the input is empty' {
        tmp E:MY-VAR = ''

        >> 'when mandatory' {
          fails {
            input:string MY-VAR
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:string &optional MY-VAR |
            should-be $nil
        }
      }

      >> 'when the input is non-empty' {
        tmp E:MY-VAR = 'dodo'

        >> 'when mandatory' {
          input:string MY-VAR |
            should-be (get-env MY-VAR)
        }

        >> 'when optional' {
          input:string &optional MY-VAR |
            should-be (get-env MY-VAR)
        }
      }

      >> 'when there are only spaces' {
        tmp E:MY-VAR = "       \t   \n                 "

        >> 'when mandatory' {
          fails {
            input:string MY-VAR
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          tmp E:MY-VAR = "       \t   \n                 "

          input:string &optional MY-VAR |
            should-be $nil
        }
      }

      >> 'when there are leading and trailing spaces' {
        tmp E:MY-VAR = '           dodo   '

        >> 'when mandatory' {
          input:string MY-VAR |
            should-be dodo
        }

        >> 'when optional' {
          input:string &optional MY-VAR |
            should-be dodo
        }
      }
    }
  }
}