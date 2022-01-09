class Shop
  # Each Shop contains an array of Shelves and a store Name.
  attr_accessor :shelves, :name, :unshelvedCandies
  def initialize(name="")
    @shelves = []
    @name = name
    @unshelvedCandies = []
  end
end
