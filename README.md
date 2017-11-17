# ruby_radix_tree
Yet another implementation of Radix Tree in Ruby

## Usage:

```ruby
tree = RadixTree.new 'she' => 1, 'sells' => 2, 'seashells' => 3, 'by' => 4, 'the' => 5
tree.put 'see', 6
tree.put 'beer'

tree.get 'see' # 6
tree.get 'foobar' # nil

tree.items # [['she', 1], ['sells', 2]...]
tree.items('b') # [['beer', nil], ['by', 4]]

tree.to_h # {'she' => 1, ...}
```
