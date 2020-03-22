#!/bin/sh -ex
type bash && shellspec -s bash --no-quick
type zsh  && shellspec -s zsh  --no-quick
type mksh && shellspec -s mksh --no-quick
type yash && shellspec -s yash --no-quick
echo Done
