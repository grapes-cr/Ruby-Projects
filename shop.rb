class Shop
  attr_accessor :shelves, :name
  def initialize(name="")
    @shelves = []
    @name = name
  end
end
