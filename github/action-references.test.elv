use ./action-references

>> 'GitHub' {
  >> 'action references' {
    >> 'Perl regex to other branches' {
      action-references:get-perl-regex-to-other-branches TEST-REPO TEST-BRANCH |
        should-be 'uses:\s+TEST-REPO[^@]*@(?!TEST-BRANCH)\s*'
    }
  }
}