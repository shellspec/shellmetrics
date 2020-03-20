all:	test check

test:
	shellspec -s bash --no-quick
	shellspec -s zsh --no-quick
	shellspec -s mksh --no-quick
	shellspec -s yash --no-quick

check:
	shellcheck shellmetrics spec/shellmetrics_spec.sh

coveralls:
	docker run -it -v "$(PWD):/src" shellspec/shellspec:kcov \
		--kcov --kcov-options "--coveralls-id=$(TRAVIS_JOB_ID)"
