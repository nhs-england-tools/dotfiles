#!/bin/bash -e

# Pre-commit git hook to check the EditorConfig rules complience over changed
# files.
#
# Usage:
#   $ ./editorconfig-pre-commit.sh
#
# Options:
#   BRANCH_NAME=other-branch-than-main  # Branch to compare with, default is `origin/main`
#   ALL_FILES=true                      # Check all files, default is `false`
#
# Exit codes:
#   0 - All files are formatted correctly
#   1 - Files are not formatted correctly
#
# Notes:
#   1) Please, make sure to enable EditorConfig linting in your IDE. For the
#   Visual Studio Code editor it is `editorconfig.editorconfig` that is already
#   specified in the `./.vscode/extensions.json` file.
#   2) Due to the file name escaping issue files are checked one by one.

# ==============================================================================

function is_arg_true() {

  if [[ "$1" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
    return 0
  else
    return 1
  fi
}

# ==============================================================================

is_arg_true "$VERBOSE" && set -x
exit_code=0
image_digest=0f8f8dd4f393d29755bef2aef4391d37c34e358d676e9d66ce195359a9c72ef3 # 2.7.0

if is_arg_true "$ALL_FILES"; then

  docker run --rm --platform linux/amd64 \
    --volume=$PWD:/check \
    mstruebing/editorconfig-checker@sha256:$image_digest \
      ec \
        --exclude '.git/'

else

  changed_files=$(git diff --diff-filter=ACMRT --name-only ${BRANCH_NAME:-origin/main})
  while read file; do
    docker run --rm --platform linux/amd64 \
      --volume=$PWD:/check \
      mstruebing/editorconfig-checker@sha256:$image_digest \
        ec \
          --exclude '.git/' \
          "$file"
    [ $? != 0 ] && exit_code=1 ||:
  done < <(echo "$changed_files")
  [ $? != 0 ] && exit_code=1 ||:

fi

exit $exit_code
