require_relative './node'

class RadixTree
  attr_reader :root

  # if `values` is given, initializes Tree with the given values
  def initialize(values = {})
    @root = nil

    values.each { |key, value| put(key, value) }
  end

  # returns a value under the given key
  def get(key)
    node = _get(@root, key)
    return nil unless node
    node.value
  end

  # adds a new key-value pair
  def put(key, value = nil)
    @root = _put(@root, key, value)
  end

  # returns true if the given key exists
  def has?(key)
    node = _get(@root, key)
    !node.nil? && !node.undefined?
  end

  # returns all items matched to the given prefix
  def items(prefix = '')
    queue = []
    collect(
      _get(@root, prefix, 0),
      prefix,
      queue
    )
    queue
  end

  # returns a hash representation of the tree
  def to_h
    Hash[items]
  end

  private

  def collect(root, prefix, queue)
    return unless root
    queue << [prefix, root.value] unless root.undefined?

    root.children.each do |char, node|
      collect(node, prefix + char, queue)
    end
  end

  def _put(node, key, value, depth = 0)
    node ||= Node.new
    if depth == key.length
      node.value = value
      return node
    end
    char = key[depth]
    node.set_child(
      char,
      _put(node.child_on(char), key, value, depth + 1)
    )
  end

  def _get(node, key, depth = 0)
    return nil unless node
    return node if key.length == depth
    char = key[depth]
    _get(node.child_on(char), key, depth + 1)
  end
end
