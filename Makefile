test:
	shellspec -s bash
	shellspec -s zsh
	shellspec -s mksh
	shellspec -s yash
check:
	shellcheck shellmetrics spec/shellmetrics_spec.sh
