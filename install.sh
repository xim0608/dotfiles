#!/bin/sh

set -e

./bin/setup

case "$(uname)" in
  "Darwin") ./bin/mitamae local $@ lib/recipe.rb ;;
  *)  sudo -E bin/mitamae local $@ lib/recipe.rb ;;
esac
