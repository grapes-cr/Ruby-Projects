require_relative "candy.rb"
require_relative "shelf.rb"
require_relative "shop.rb"

puts "Name your store."
store = gets.chomp
store = Shop.new(store)
puts "\nYour new store, #{store.name} has been created! \nHow many shelves do you want?"
numShelves = gets.chomp.to_i
numShelves.times { store.shelves.push(Shelf.new) }
if numShelves > 0
  puts "\nAwesome! #{store.name} has #{numShelves} shelves. \nLet's add some candies to your first shelf. Which candies would you like to add? (Separate your entries by a comma.)"
  candyCount = 0
  candy = gets.chomp.split(",")
  while candyCount < candy.length
    store.shelves[0].candies.push(Candy.new(candy[candyCount]))
    candyCount += 1
  end
else
  puts "\nYour store doesn't have any shelves."
end
puts "\nSweet! Your first shelf has: "
store.shelves[0].candies.each { |candy| print "#{candy.name}, "}
puts " (#{store.shelves[0].candies.length} candies in total)"

if numShelves > 1
  puts "\nLet's populate the rest of your shelves."
  shelfCount = 1
  while shelfCount < numShelves
    candyCount = 0
    puts "\n\nShelf #{shelfCount+1}: Input your candies (Separate your entries with a comma)."
    candy = gets.chomp.split(",")
    while candyCount < candy.length
      store.shelves[shelfCount].candies.push(Candy.new(candy[candyCount]))
      candyCount += 1
    end
    puts "\nShelf #{shelfCount+1} stocked with: "
    store.shelves[shelfCount].candies.each { |candy| print "#{candy.name}, "}
    puts " (#{store.shelves[shelfCount].candies.length} candies in total)"
    shelfCount +=1
  end
end
puts "\nCongrats! #{store.name} is now created."
