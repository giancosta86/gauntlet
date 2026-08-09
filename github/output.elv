fn set { |key context-value|
  echo $key'='$context-value >> (get-env GITHUB_OUTPUT)
}