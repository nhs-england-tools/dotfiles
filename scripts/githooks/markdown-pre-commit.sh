#!/bin/bash -e

# Pre-commit git hook to check the Markdown rules complience over changed
# files.
#
# Usage:
#   $ ./markdown-pre-commit.sh
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
#   Please, make sure to enable Markdown linting in your IDE. For the Visual
#   Studio Code editor it is `davidanson.vscode-markdownlint` that is already
#   specified in the `./.vscode/extensions.json` file.

# ==============================================================================

image_digest=3e42db866de0fc813f74450f1065eab9066607fed34eb119d0db6f4e640e6b8d # v0.34.0
changed_files=$([[ "$ALL_FILES" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]] && \
  git grep --cached -Il '' | grep '.md$' || \
  git diff --diff-filter=ACMRT --name-only ${BRANCH_NAME:-origin/main} *.md \
)

if [ -n "$changed_files" ]; then
  image=ghcr.io/igorshubovych/markdownlint-cli@sha256:$image_digest
  docker run --rm \
    -v $PWD:/workdir \
    $image \
      $changed_files \
      --disable MD013 MD033
fi

exit 0
