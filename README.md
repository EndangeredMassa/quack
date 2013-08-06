# quack

A simple BDD testing framework. There are no spy, stub, or assertion methods provided.

The goal is to be the simplest testing framework possible that allows you to (1) extend however you want and (2) add supporting libraries to create your own testing stack.


## todo features

- describe/it/beforeEach/afterEach/before/after
- gunit.getEnv() or equivalent: allows registering a single after block for the current test
- command-line and html reporters (start with TAP only output)
- setup/teardown hooks of gunit itself
- 0 tests == suite failure
- proper exit codes
- 0 asserts in a test == test failure
