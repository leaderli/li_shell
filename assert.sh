function @assert-equals() {
  declare expected="${1:?missing the expected result}" actual="${2:?missing the actual result}"

  if [[ "${expected}" == "${actual}" ]]; then
    cat <<EOF
    [assert-equals] expected: ${expected}
##                         actual: ${actual}
EOF
  else
    cat <<EOF
Assert Failed:
     Expected: $expected
      But got: $actual
EOF
  fi
}
export -f @assert-equals

function @assert-success() {

  @assert-equals "0" "$?"
}
