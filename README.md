# Rails throttling example

[![Code Climate](https://codeclimate.com/github/kimquy/rate_limitter/badges/gpa.svg)](https://codeclimate.com/github/kimquy/rate_limitter)

[![Build Status](https://travis-ci.org/kimquy/rate_limitter.svg?branch=master)](https://travis-ci.org/kimquy/rate_limitter)

# Manual Testing

* Make a single request from command line with Curl

Simply copy the code below into command line. Curl is required.

```bash
curl https://ln-rate-limitter.herokuapp.com/home/index
```

* Make multiple request from command line with Curl

```bash
for i in {1..5}; do curl https://ln-rate-limitter.herokuapp.com/home/index; done
```

# Unit test

```ruby
bundle exec rspec
```
