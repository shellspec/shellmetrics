test:
	shellspec -s bash
	shellspec -s zsh
	shellspec -s mksh
	shellspec -s yash

check:
	shellcheck shellmetrics spec/shellmetrics_spec.sh

coveralls:
	docker run -it -v "$(PWD):/src" shellspec/shellspec:kcov \
		--kcov --kcov-options "--coveralls-id=$(TRAVIS_JOB_ID)"
