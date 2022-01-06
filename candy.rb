class Candy
  attr_accessor :name, :shelved
  def initialize(name="")
    @name = name
    @shelved = false
  end
end

#taffy = Candy.new("Taffy")
#puts "#{taffy.name} #{taffy.shelved}"
