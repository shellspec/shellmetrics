all:	test check

test:
	./test.sh

check:
	shellcheck shellmetrics spec/*.sh

coveralls:
	docker run -it -v "$(PWD):/src" shellspec/shellspec:kcov \
		--kcov --kcov-options "--coveralls-id=$(TRAVIS_JOB_ID)"
