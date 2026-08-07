use ./tests/fake-context

fake-context:within github {
  use ./input

  fn run-single-value-tests { |processor valid-input valid-result|
    >> 'when the input is missing' {
      var missing-var-name = SOME-MISSING-VAR

      >> 'when mandatory' {
        fails {
          $processor $missing-var-name
        } |
          should-be 'Missing input: '$missing-var-name
      }

      >> 'when optional' {
        $processor &optional $missing-var-name |
          should-be $nil
      }
    }

    >> 'when the input is empty' {
      tmp E:MY-VAR = ''

      >> 'when mandatory' {
        fails {
          $processor MY-VAR
        } |
          should-be 'Missing input: MY-VAR'
      }

      >> 'when optional' {
        $processor &optional MY-VAR |
          should-be &strict $nil
      }
    }

    >> 'when the input has just spaces' {
      tmp E:MY-VAR = "       \t   \n                 "

      >> 'when mandatory' {
        fails {
          $processor MY-VAR
        } |
          should-be 'Missing input: MY-VAR'
      }

      >> 'when optional' {
        $processor &optional MY-VAR |
          should-be &strict $nil
      }
    }

    >> 'when the input is valid' {
      tmp E:MY-VAR = $valid-input

      >> 'when mandatory' {
        $processor MY-VAR |
          should-be &strict $valid-result
      }

      >> 'when optional' {
        $processor &optional MY-VAR |
          should-be &strict $valid-result
      }
    }

    >> 'when the valid input has leading and trailing spaces' {
      tmp E:MY-VAR = "    \t  \n        "$valid-input"    \n \n \t      "

      >> 'when mandatory' {
        $processor MY-VAR |
          should-be &strict $valid-result
      }

      >> 'when optional' {
        $processor &optional MY-VAR |
          should-be &strict $valid-result
      }
    }
  }

  >> 'Input' {
    >> 'string' {
      run-single-value-tests $input:string~ dodo dodo
    }

    >> 'number' {
      run-single-value-tests $input:number~ 90 (num 90)

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
      run-single-value-tests $input:bool~ true $true

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

      var processor = { |&optional=$false var-name|
        input:enum &optional=$optional $var-name $admissible
      }

      run-single-value-tests $processor beta beta

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
    }

    >> 'list' {
      >> 'when the input is missing' {
        input:list SOME-INEXISTING-VAR |
          should-be &strict []
      }

      >> 'when the input is empty' {
        tmp E:MY-VAR = ''

        input:list MY-VAR |
          should-be &strict []
      }

      >> 'when there are only spaces' {
        tmp E:MY-VAR = "       \t   \n                 "

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

      >> 'when there are multiple items, with leading and trailing spaces' {
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
        tmp E:MY-VAR = ',   alpha,,,,beta,,gamma,   ,'

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