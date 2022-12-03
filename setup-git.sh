#!/bin/bash

git config --global user.name "Nils Bergmann"
git config --global user.email "nilsbergmann@noim.io"

git config --global --unset gpg.format
git config --global user.signingkey 5FAEC08EE1DC2DF9
git config --global commit.gpgsign true