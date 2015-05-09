.PHONY:
tests:
	prove -v t

.PHONY:
list:
	grep -e '^#:' -h t/*.t | sed -e 's/^#: *//'
