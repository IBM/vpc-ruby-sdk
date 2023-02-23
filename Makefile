# This makefile is used to make it easier to run the tests.

test-unit:
	bundle exec rake test:unit

test-example:
	bundle exec rake test:examples

test-int:
	bundle exec rake test:integration