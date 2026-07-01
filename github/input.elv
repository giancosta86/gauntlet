fn get-string { |name|
  if (has-env $name) {
    get-env $name
  } else {
    put $nil
  }
}