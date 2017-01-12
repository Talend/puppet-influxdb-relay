#!/bin/sh
# -------------
#  global conf
# -------------
PROJECT_NAME="puppet-influxdb-relay"
MODULE_NAME="talend-influxdb_relay"
TEST_EXAMPLE="influxdb-relay-centos-72"
SCRIPT_NAME=$(basename $0)
if which tput >/dev/null 2>&1 && tput setaf >/dev/null 2>&1; then
  export FCOLOR_PROMPT=0
  export COLOR_TITLE="\033[35m" #Magenta
  export COLOR_ERROR="\033[31m" #Red
  export COLOR_WARNING="\033[33m" #Yellow
  export COLOR_INFO="\033[36m" #Cyan
  export ENDCOLOR="\033[0m"
else
  export FCOLOR_PROMPT=1
  export COLOR_ERROR=""
  export COLOR_WARNING=""
  export COLOR_INFO=""
  export ENDCOLOR=""
fi

# ------------
#  functions
# -----------
fShowHelp(){
  cat << EOF
${SCRIPT_NAME} [options]
  with options:
    -h: this message
    -c: clean legacy installation before launching test
    -l: list available tests and exit
    -s: syntax check only and exit
    -t testname: launch this specific test only

  Example of use:
  launch all the tests: ${SCRIPT_NAME}
  launch all the test but (re)install everything before: ${SCRIPT_NAME} -c
  list the tests availables: ${SCRIPT_NAME} -l
  launch a specific test:  ${SCRIPT_NAME} -t "${TEST_EXAMPLE}"
  launch a syntax check: ${SCRIPT_NAME} -s

  Tips:
    if the syntax check fail with alignment errors, maybe you can fix it with the following command for each file in error:
    bundle exec puppet-lint --fix \$PWD/filepath-given-in-error.pp

EOF
  return 0
}

fError(){
  /bin/echo -e "${COLOR_ERROR}#[$(date --rfc-3339=seconds)][ERROR] ${@}${ENDCOLOR}" 1>&2
  exit 1
}

fTitle(){
  /bin/echo -e "${COLOR_TITLE}#====================================================================="
  /bin/echo  "# ${@}"
  /bin/echo -e "#=====================================================================${ENDCOLOR}"
}

fMessage(){
  /bin/echo -e "${COLOR_INFO}#[$(date --rfc-3339=seconds)] ${@}${ENDCOLOR}"
}

fWarning(){
  /bin/echo -e "${COLOR_WARNING}#[$(date --rfc-3339=seconds)][WARNING] ${@}${ENDCOLOR}" 1>&2
}


# ------------
#  main
# ------------
TEST_NAME="all"
LIST_MODE=0
CLEAN_MODE=0
SYNTAX_ONLY=0

while getopts hclst: option
do
  case "${option}" in
    h) fShowHelp; exit $?;;
    c) export CLEAN_MODE=1;;
    l) export LIST_MODE=1;;
    t) export TEST_NAME="${OPTARG}";;
    s) export SYNTAX_ONLY=1;;
    \?) fShowHelp;  fError "Unknown option -${option}";;
  esac
done


BUNDLER=$(which bundle)
if [ -z "$BUNDLER" ]; then
  fError "ERROR: No Bundler installed "
fi

test -f ./metadata.json && grep -q "^  \"name\": \"${MODULE_NAME}\",$" ./metadata.json
if [ $? -ne 0 ]; then
  fError "ERROR: You must be inside the directory ${PROJECT_NAME} to execute this script
  => cd ./${PROJECT_NAME}"
fi


if [ ${CLEAN_MODE} -eq 1 ]; then
  fTitle  "Removing legacy installation"
  for directory in "./modules" "./vendor" "./.bundle" "./.vagrant" "./.kitchen" "./.tmp"; do
    fMessage "Removing directory ${directory}"
    test -n "${directory}" && rm -Rf ${directory}
  done
fi

set -e
### Install bundle
fTitle "Install bundle stuff"
bundle install --path=vendor/bundle --with=development
bundle exec librarian-puppet install --clean

### clean ?
if [ ${LIST_MODE} -eq 1 ]; then
  fTitle "Available tests"
  bundle exec kitchen list
  exit $?
fi

fTitle "Validating code"
bundle exec rake validate lint spec
RETURN=$?
test $SYNTAX_ONLY -eq 1 && exit $RETURN

### test !
fTitle "Execute tests"
bundle exec kitchen test ${TEST_NAME}
exit $?
