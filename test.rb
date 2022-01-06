class candy
  attr_accessor :name, :shelved?
  def initialize(name)
    @name = name
    @shelved? = false
  end
end

taffy = candy.new(taffy)
puts #{taffy.name} #{taffy.shelved?}
