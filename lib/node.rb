class Node
  MAP = ('a'..'z').to_a + ('A'..'Z').to_a

  attr_accessor :value

  def initialize
    @value = undefined_value
    @children = Array.new(MAP.count)
    @parent = nil
  end

  # returns a node under the given char
  def child_on(char)
    @children[char_to_index(char)]
  end

  # connects a node to the given char
  def set_child(char, node)
    @children[char_to_index(char)] = node
    self
  end

  # returns all existing children in pairs [[char, node]]
  def children
    MAP.zip(@children).select { |pair| pair[1] }
  end

  # returns true if the node does not have value
  def undefined?
    @value == undefined_value
  end

  def inspect
    children_string = children.map { |p| p[0] }.join(', ')
    "<Node value=#{value || 'nil'} children=[#{children_string}]>"
  end

  private

  # It's not a constant to avoid using this value from outside of the class
  # and assigning as a value
  def undefined_value
    @undefined_value ||= Object.new
  end

  def char_to_index(char)
    MAP.index(char)
  end
end
