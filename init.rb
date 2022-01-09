require_relative "candy.rb"
require_relative "shelf.rb"
require_relative "shop.rb"

done = false
looseShelves = []
looseCandies = []
shopList = []

while not done
  puts "\nWelcome to the Candy Shop Maker! Main menu: \n1: Create a Shop \n2: Create, Add, or Remove a Shelf \n3: Create, Add, or Remove Candies \n4: View Your Shelves \n5: View Your Candies \n6: Exit"
  menuInput = gets.chomp.to_i
  case menuInput
  when 1
    # Asks user to fully build a shop with shelves and candy.
    puts "\nName your store."
    store = gets.chomp
    store = Shop.new(store)
    shopList.push(store)
    puts "\nYour new store, #{store.name} has been created! \nHow many shelves do you want?"
    numShelves = gets.chomp.to_i
    if numShelves <= 0
      print "\nNo shelves, no problem. We can add some later."
    else
      numShelves.times { store.shelves.push(Shelf.new) }
      puts "\nAwesome! #{store.name} has #{numShelves} shelves. \nLet's add some candies to your first shelf. Which candies would you like to add? (Separate your entries by a comma.)"
      candyCount = 0
      candy = gets.chomp.split(",")
      while candyCount < candy.length
        store.shelves[0].candies.push(Candy.new(candy[candyCount]))
        store.shelves[0].candies[candyCount].isShelved = true
        candyCount += 1
      end
      puts "\nSweet! Your first shelf has: "
      store.shelves[0].candies.each { |candy| print "#{candy.name}, "}
      puts " (#{store.shelves[0].candies.length} candies in total)"
    end

    if numShelves > 1
      puts "\nLet's populate the rest of your shelves."
      shelfCount = 1
      while shelfCount < numShelves
        candyCount = 0
        puts "\nShelf #{shelfCount+1}: Input your candies (Separate your entries with a comma)."
        candy = gets.chomp.split(",")
        while candyCount < candy.length
          store.shelves[shelfCount].candies.push(Candy.new(candy[candyCount]))
          store.shelves[shelfCount].candies[candyCount].isShelved = true
          candyCount += 1
        end
        puts "\nShelf #{shelfCount+1} stocked with: "
        store.shelves[shelfCount].candies.each { |candy| print "#{candy.name}, "}
        puts " (#{store.shelves[shelfCount].candies.length} candies in total)"
        shelfCount +=1
      end
    end
    puts "\nCongrats! #{store.name} is now created."

  when 2
    puts "\n1: Create a Shelf \n2: Add a Shelf to Shop \n3: Remove a Shelf from Shop \n4: Remove a Shelf in Storage"
    input = gets.chomp.to_i
    case input
    when 1
      # Create shelves.
      puts "\nHow many shelves would you like to build?"
      numShelves = gets.chomp.to_i
      if numShelves <= 0
        print "\nI won't make any shelves, then."
      else
        numShelves.times { looseShelves.push(Shelf.new) }
        puts "\nNice! I made #{numShelves} shelves for you."
      end

    when 2
      # Add a shelf to a shop.
      if shopList.length <= 0
        puts "\nYou don't currently have any shops. You can create one in the main menu."
      elsif looseShelves.length <= 0
        puts "\nYou don't have any shelves. You should create one first."
      else
      puts "\nYou currently have #{looseShelves.length} shelves in storage. Which shelf would you like to add to a shop? (Input the number of the shelf.)"
      shelves = gets.chomp.to_i
      if shelves < 1 or shelves > looseShelves.length
        puts "You don't have that many shelves.."
      else
        puts "\nWhich shop would you like to add shelf #{shelves} in? Your shops: "
        shopList.each { |shop| print "#{shop.name}, "}
        print "(#{shopList.length} in total). Type the number of shop you want.\n"
        shops = gets.chomp.to_i
        if shops < 1 or shops > shopList.length
          puts "You don't have that many shops.."
        else
          shopList[shops-1].shelves.push(looseShelves[shelves-1])
          looseShelves.delete_at(shelves-1)
          puts "#{shopList[shops-1].shelves}"
        end
      end
    end

  when 3
    if shopList.length <= 0
      puts "\nYou don't have any shops. You can create one in the main menu."
    else
      puts "\nYou currently have #{shopList.length} shops. Select a shop (Input the shop number)."
      shops = gets.chomp.to_i
      if shops < 1 or shops > shopList.length
        puts "You don't have that many shops.."
      else
        puts "\n#{shopList[shops-1].name} has #{shopList[shops-1].shelves.length} shelves. Which shelf would you like to remove?"
        shelves = gets.chomp.to_i
        if shelves < 1 or shelves > shopList[shops-1].shelves.length
          puts "#{shopList[shops-1]} doesn't have that many shelves."
        else
          shopList[shops-1].shelves.delete_at(shelves-1)
          puts "#{shopList[shops-1].shelves}"
        end
      end
    end


  when 4
    # Remove a shelf.
    if looseShelves.length <= 0
      puts "\nYou don't have any shelves."
    else
      puts "\nYou currently have #{looseShelves.length} shelves in storage. Which shelf would you like to remove? (Input the number of the shelf.)"
      shelves = gets.chomp.to_i
      if shelves < 1 or shelves > looseShelves.length
        puts "You don't have that many shelves.."
      else
        looseShelves.delete_at(shelves-1)
        puts "#{looseShelves}"
      end
    end
  else
    puts "\nI didn't understand that."
  end

when 3
  puts "yes"

when 4
  puts "\n1: View Shelves in a Shop \n2:View Shelves in Storage"
  count = 1
  input = gets.chomp.to_i
  if input < 1 or input > 2
    puts "\nI didn't understand that."
  elsif shopList.length <= 0
    puts "\nYou don't currently have any shops. You can create one in the main menu."
  else
    puts "\nYou currently have #{shopList.length} shops. Select a shop (Input the shop number)."
    shops = gets.chomp.to_i
    if shops < 1 or shops > shopList.length
      puts "You don't have that many shops.."
    elsif shopList[shops-1].shelves.length <= 0
      puts "#{shopList[shops-1]} doesn't have any shelves."
    else
      puts "\n#{shopList[shops-1].name} has #{shopList[shops-1].shelves.length} shelves."
      shopList[shops-1].shelves.each do |shelf|
        print "\nShelf #{count} has candies: "
        shelf.candies.each { |candy| print "#{candy.name}, "}
        print "(#{shelf.candies.length} candies in total)."
        count += 1
      end
      puts "\n"
    end
  end



when 5
  puts "\nView Your Candies"
when 6
  done = true
else
  puts "\nI didn't quite understand that. Can you try again?"
end
end
