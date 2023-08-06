@out() {
  builtin echo $0
  while IFS= read -r line; do
    builtin echo " $line"
  done
}

function @assert-equals() {
  declare expected="${1:?missing the expected result}" actual="${2:?missing the actual result}"

  if [[ "${expected}" != "${actual}" ]]; then
    @out <<EOF
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
function @assert-fail() {
  declare expected="<non-zero>" actual="$?"
  [[ "$actual" -eq 0 ]] || expected="$actual"
  @assert-equals "$expected" "$actual"
}
