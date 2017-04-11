# Joje [![Build Status](https://travis-ci.org/Monk-NT/Joje.svg?branch=master)](https://travis-ci.org/Monk-NT/Joje) [![Coverage Status](https://coveralls.io/repos/github/Monk-NT/Joje/badge.svg?branch=master)](https://coveralls.io/github/Monk-NT/Joje?branch=master)

Joje is a simple Haskell web framework. It's main purpose is to be a light wrapper
around WAI/Warp.

## How to run

For basic example, use
```bash
  stack runghc examples\Basic.hs
```

## TODO

This todo is to be expanded as development progresses. Current entries are:

  * Allowing verbs for different routes
  * Tests
  * Comment code
  * Route parser


## Roadmap

### 0.1.0

  * Working router - can parse route, get parameters and send
  it to adequate handler function
  * Change to Library
  * Add basic tests
