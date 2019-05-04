#!/usr/bin/env bats

# Constants
NEWLINE="$(printf '\n')"
TAB="$(printf '\t')"

# Dependencies
if [[ "$(command -v make)" = "" ]]; then
  echo "Required dependency \`make\` is not found in your \$PATH";
  exit 1;
fi

if [[ "$(command -v grep)" = "" ]]; then
  echo "Required dependency \`grep\` is not found in your \$PATH";
  exit 1;
fi

setup() {
  mkdir -p "${BATS_TMPDIR}/make"
  cp -r ./config "${BATS_TMPDIR}/make/"
}

teardown() {
  rm -rf "${BATS_TMPDIR}/make"
}

@test "dep present" {
  cat "${BATS_TEST_DIRNAME}/../dep.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
test: dep.make
${TAB}@ echo "ok"
EOF
  run make -f "${BATS_TMPDIR}/make/Makefile" test
  [ "$status" -eq 0 ]
  [ "$output" = "ok" ]
}

@test "dep not present" {
  cat "${BATS_TEST_DIRNAME}/../dep.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
test: dep.makez
${TAB}@ echo "ok"
EOF
  run make -f "${BATS_TMPDIR}/make/Makefile" test
  [ "$status" -eq 2 ]
  [ "${lines[0]}" = "Required dependency \`makez\` is not found in your \$PATH." ]
  [ "${lines[1]}" = "make: *** [dep.makez] Error 1" ]
}

@test "env present" {
  cat "${BATS_TEST_DIRNAME}/../env.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
test: env.OK
${TAB}@ echo \${OK}
EOF
  OK="ok" run make -f "${BATS_TMPDIR}/make/Makefile" test
  [ "$status" -eq 0 ]
  [ "$output" = "ok" ]
}

@test "env no present" {
  cat "${BATS_TEST_DIRNAME}/../env.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
test: env.OK
${TAB}@ echo \${OK}
EOF
  run make -f "${BATS_TMPDIR}/make/Makefile" test
  [ "$status" -eq 2 ]
  [ "${lines[0]}" = "Required variable \`OK\` is not set." ]
  [ "${lines[1]}" = "make: *** [env.OK] Error 1" ]
}

@test "help simple" {
  cat "${BATS_TEST_DIRNAME}/../help.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
## Test file
test:
${TAB}@ echo "ok"
EOF
  run make -f "${BATS_TMPDIR}/make/Makefile" help
  [ "$status" -eq 0 ]
  echo $output | grep "Usage"
  echo $output | grep "help"
  echo $output | grep "Displays this help message"
  echo $output | grep "test"
  echo $output | grep "Test file"
}

@test "help section" {
  skip
  cat "${BATS_TEST_DIRNAME}/../help.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
## Test file
test:
${TAB}@ echo "ok"
EOF
  run make -f "${BATS_TMPDIR}/make/Makefile" help
  [ "$status" -eq 0 ]
  # echo $output | grep "Usage"
  # echo $output | grep "help"
  # echo $output | grep "Displays this help message"
  # echo $output | grep "test"
  # echo $output | grep "Test file"
}

@test "help multiline" {
  skip
  cat "${BATS_TEST_DIRNAME}/../help.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
## Test file
test:
${TAB}@ echo "ok"
EOF
  run make -f "${BATS_TMPDIR}/make/Makefile" help
  [ "$status" -eq 0 ]
  # echo $output | grep "Usage"
  # echo $output | grep "help"
  # echo $output | grep "Displays this help message"
  # echo $output | grep "test"
  # echo $output | grep "Test file"
}

@test "eread" {
  cat "${BATS_TEST_DIRNAME}/../read.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
test: eread.OK
${TAB}@ echo \${OK}
EOF
  OK="ok" run make -f "${BATS_TMPDIR}/make/Makefile" test
  [ "$status" -eq 0 ]
  [ "$output" = "ok" ]
}

@test "ensure all works" {
  cat "${BATS_TEST_DIRNAME}/../all.mk" > "${BATS_TMPDIR}/make/Makefile"
  cat <<EOF >> "${BATS_TMPDIR}/make/Makefile"
${NEWLINE}
test: eread.OK
${TAB}@ echo \${OK}
EOF
  OK="ok" run make -f "${BATS_TMPDIR}/make/Makefile" test
  echo "$output"
  [ "$status" -eq 0 ]
  [ "$output" = "ok" ]
}