STACKAGE_NIGHTLY := $(shell date -d "yesterday 13:00 " '+%Y-%m-%d')

cabal.config:
	curl -s https://www.stackage.org/snapshot/nightly-$(STACKAGE_NIGHTLY)/cabal.config > cabal.config
