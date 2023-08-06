function @assert-equals() {
  declare expected="${1:?missing the expected result}" actual="${2:?missing the actual result}"

  if [[ "${expected}" == "${actual}" ]]; then
    cat <<EOF
    [assert-equals] expected: ${expected}
##                         actual: ${actual}
EOF
  else
    @die - 2>&7 <<EOF
Assert Failed:
     Expected: $expected
      But got: $actual
EOF
  fi
} >&7
export -f @assert-equals

function @assert-success() {

  @assert-equals "0" "$?"
}
