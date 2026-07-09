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

    >> 'number' {
      >> 'when the input is missing' {
        >> 'when mandatory' {
          fails {
            input:number SOME-INEXISTING-VAR
          } |
            should-be 'Missing input: SOME-INEXISTING-VAR'
        }

        >> 'when optional' {
          input:number &optional SOME-INEXISTING-VAR |
            should-be $nil
        }
      }

      >> 'when the input is empty' {
        tmp E:MY-VAR = ''

        >> 'when mandatory' {
          fails {
            input:number MY-VAR
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:number &optional MY-VAR |
            should-be $nil
        }
      }

      >> 'when the input is non-empty' {
        tmp E:MY-VAR = '90'

        >> 'when mandatory' {
          input:number MY-VAR |
            should-be &strict (num 90)
        }

        >> 'when optional' {
          input:number &optional MY-VAR |
            should-be &strict (num 90)
        }
      }

      >> 'when there are only spaces' {
        tmp E:MY-VAR = "       \t   \n                 "

        >> 'when mandatory' {
          fails {
            input:number MY-VAR
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:number &optional MY-VAR |
            should-be $nil
        }
      }

      >> 'when there are leading and trailing spaces' {
        tmp E:MY-VAR = "        \t   90   \n   "

        >> 'when mandatory' {
          input:number MY-VAR |
            should-be &strict (num 90)
        }

        >> 'when optional' {
          input:number &optional MY-VAR |
            should-be &strict (num 90)
        }
      }

      >> 'when the input is not a number' {
        tmp E:MY-VAR = dodo

        >> 'when mandatory' {
          throws {
            input:number MY-VAR
          } |
            exception:get-reason |
            to-string (all) |
            should-contain dodo
        }

        >> 'when optional' {
          throws {
            input:number &optional MY-VAR
          } |
            exception:get-reason |
            to-string (all) |
            should-contain dodo
        }
      }
    }

    >> 'boolean' {
      >> 'when the input is missing' {
        >> 'when mandatory' {
          fails {
            input:bool SOME-INEXISTING-VAR
          } |
            should-be 'Missing input: SOME-INEXISTING-VAR'
        }

        >> 'when optional' {
          input:bool &optional SOME-INEXISTING-VAR |
            should-be $nil
        }
      }

      >> 'when the input is empty' {
        tmp E:MY-VAR = ''

        >> 'when mandatory' {
          fails {
            input:bool MY-VAR
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:bool &optional MY-VAR |
            should-be $nil
        }
      }

      >> 'when the input is true' {
        tmp E:MY-VAR = 'true'

        >> 'when mandatory' {
          input:bool MY-VAR |
            should-be &strict $true
        }

        >> 'when optional' {
          input:bool &optional MY-VAR |
            should-be &strict $true
        }
      }

      >> 'when the input is false' {
        tmp E:MY-VAR = 'false'

        >> 'when mandatory' {
          input:bool MY-VAR |
            should-be &strict $false
        }

        >> 'when optional' {
          input:bool &optional MY-VAR |
            should-be &strict $false
        }
      }

      >> 'when there are only spaces' {
        tmp E:MY-VAR = "       \t   \n                 "

        >> 'when mandatory' {
          fails {
            input:bool MY-VAR
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:bool &optional MY-VAR |
            should-be $nil
        }
      }

      >> 'when there are leading and trailing spaces' {
        tmp E:MY-VAR = '           true   '

        >> 'when mandatory' {
          input:bool MY-VAR |
            should-be &strict $true
        }

        >> 'when optional' {
          input:bool &optional MY-VAR |
            should-be &strict $true
        }
      }

      >> 'when the input is not a boolean' {
        tmp E:MY-VAR = dodo

        >> 'when mandatory' {
          fails {
            input:bool MY-VAR
          } |
            should-be 'Invalid bool value for the ''MY-VAR'' input: ''dodo'''
        }

        >> 'when optional' {
          fails {
            input:bool &optional MY-VAR
          } |
            should-be 'Invalid bool value for the ''MY-VAR'' input: ''dodo'''
        }
      }
    }
  }
}