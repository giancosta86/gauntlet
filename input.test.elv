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

    >> 'enum' {
      var admissible = [alpha beta gamma]

      >> 'when the input is missing' {
        >> 'when mandatory' {
          fails {
            input:enum SOME-INEXISTING-VAR $admissible
          } |
            should-be 'Missing input: SOME-INEXISTING-VAR'
        }

        >> 'when optional' {
          input:enum &optional SOME-INEXISTING-VAR $admissible |
            should-be $nil
        }
      }

      >> 'when the input is empty' {
        tmp E:MY-VAR = ''

        >> 'when mandatory' {
          fails {
            input:enum MY-VAR $admissible
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:enum &optional MY-VAR $admissible |
            should-be $nil
        }
      }

      >> 'when the input is one of the values' {
        tmp E:MY-VAR = $admissible[1]

        >> 'when mandatory' {
          input:enum MY-VAR $admissible |
            should-be &strict $admissible[1]
        }

        >> 'when optional' {
          input:enum &optional MY-VAR $admissible |
            should-be &strict $admissible[1]
        }
      }

      >> 'when the input is not one of the values' {
        tmp E:MY-VAR = 'some-other-value'

        >> 'when mandatory' {
          fails {
            input:enum MY-VAR $admissible
          } |
            should-be 'Invalid enum value for the ''MY-VAR'' input: ''some-other-value'''
        }

        >> 'when optional' {
          fails {
            input:enum &optional MY-VAR $admissible
          } |
            should-be 'Invalid enum value for the ''MY-VAR'' input: ''some-other-value'''
        }
      }

      >> 'when there are only spaces' {
        tmp E:MY-VAR = "       \t   \n                 "

        >> 'when mandatory' {
          fails {
            input:enum MY-VAR $admissible
          } |
            should-be 'Missing input: MY-VAR'
        }

        >> 'when optional' {
          input:enum &optional MY-VAR $admissible |
            should-be $nil
        }
      }

      >> 'when there are leading and trailing spaces' {
        tmp E:MY-VAR = '           '$admissible[1]'   '

        >> 'when mandatory' {
          input:enum MY-VAR $admissible |
            should-be &strict $admissible[1]
        }

        >> 'when optional' {
          input:enum &optional MY-VAR $admissible |
            should-be &strict $admissible[1]
        }
      }
    }

    >> 'list' {
      >> 'when the input is missing' {
        input:list SOME-INEXISTING-VAR |
          should-be []
      }

      >> 'when the input is empty' {
        tmp E:MY-VAR = ''

        input:list MY-VAR |
          should-be []
      }

      >> 'when the input contains one item' {
        tmp E:MY-VAR = hello

        input:list MY-VAR |
          should-be &strict [hello]
      }

      >> 'when the input contains multiple items' {
        tmp E:MY-VAR = 'cip, ciop, yogi, bubu'

        input:list MY-VAR |
          should-be &strict [
            cip
            ciop
            yogi
            bubu
          ]
      }

      >> 'when there are only spaces' {
        tmp E:MY-VAR = "       \t   \n                 "

        input:list MY-VAR |
          should-be []
      }

      >> 'when there are leading and trailing spaces' {
        tmp E:MY-VAR = "           alpha,    \t    beta,gamma      , delta     "

        input:list MY-VAR |
          should-be &strict [
            alpha
            beta
            gamma
            delta
          ]
      }

      >> 'when the input uses a different separator' {
        tmp E:MY-VAR = 'alpha; beta; gamma'

        input:list &separator=';' MY-VAR |
          should-be [
            alpha
            beta
            gamma
          ]
      }

      >> 'when there are empty items' {
        tmp E:MY-VAR = ',   alpha,,,,beta,,gamma,   '

        input:list MY-VAR |
          should-be [
            alpha
            beta
            gamma
          ]
      }
    }
  }
}