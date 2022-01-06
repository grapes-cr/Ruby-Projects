require_relative "candy.rb"
require_relative "shelf.rb"
require_relative "shop.rb"

candyland = Shop.new
shelf1 = Shelf.new
c1 = Candy.new("Taffy")
c2 = Candy.new("Chocolate")

shelf1.candies << c1
shelf1.candies << c2

shelf1.candies.each { |candy| puts "#{candy.name}, #{candy.shelved}" }
