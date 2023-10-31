# Robot Toy Simulator

- Tested on ruby 3.2.2

# Install & run again test data

```console
  bundle
  for f in test_inputs/*.txt; do echo "=== Testing against $f"; bundle exec ruby simulate.rb < $f; echo; done
```
