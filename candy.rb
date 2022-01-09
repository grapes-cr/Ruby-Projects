class Candy
  # Candy contains a name and a boolean to show if it is shelved or not.
  attr_accessor :name, :isShelved
  def initialize(name="")
    @name = name
    @isShelved = false
  end
end
