all:	test check

test:
	if type bash; then shellspec -s bash --no-quick; fi
	if type zsh;  then shellspec -s zsh --no-quick;  fi
	if type mksh; then shellspec -s mksh --no-quick; fi
	if type yash; then shellspec -s yash --no-quick; fi

check:
	shellcheck shellmetrics spec/shellmetrics_spec.sh

coveralls:
	docker run -it -v "$(PWD):/src" shellspec/shellspec:kcov \
		--kcov --kcov-options "--coveralls-id=$(TRAVIS_JOB_ID)"
