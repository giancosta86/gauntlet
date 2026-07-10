fn get-perl-regex-to-other-branches { |full-repository-name current-branch|
  put 'uses:\s+'$full-repository-name'[^@]+@(?!'$current-branch')\s*'
}
