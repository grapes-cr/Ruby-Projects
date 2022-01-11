require_relative "candy.rb"
require_relative "shelf.rb"
require_relative "shop.rb"

done = false
shopList = []

while not done
  puts "\nWelcome to the Candy Shop Maker! Main menu: \n1: Create a Shop \n2: Create, Add, or Remove a Shelf \n3: Create, Add, or Remove Candies \n4: View Your Shelves \n5: View Your Candies \n6: Exit"
  print "\nYour Input: "
  menuInput = gets.chomp.to_i
  case menuInput
  when 1
    # Asks user to fully build a shop with shelves and candy. COMPLETED
    puts "\nName your store."
    print "\nYour Input: "
    store = gets.chomp
    store = Shop.new(store)
    shopList.push(store)
    puts "\nYour new store, #{store.name} has been created! \nHow many shelves do you want?"
    print "\nYour Input: "
    numShelves = gets.chomp.to_i
    if numShelves <= 0
      print "\nNo shelves, no problem. We can add some later."
    else
      numShelves.times { store.shelves.push(Shelf.new) }
      puts "\nAwesome! #{store.name} has #{numShelves} shelves. \nLet's add some candies to your first shelf. Which candies would you like to add? (Separate your entries by a comma.)"
      print "\nYour Input: "
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
        print "\nYour Input: "
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
    puts "\n1: Create Shelves \n2: Remove a Shelf from Shop"
    print "\nYour Input: "
    input = gets.chomp.to_i
    case input
    when 1
      # Create shelves. COMPLETED
      shopCount = 1
      if shopList.length <= 0
        puts "\nYou don't currently have any shops. You can create one in the main menu."
      else
        puts "\nYou currently have #{shopList.length} shops. Select a shop to build shelves in. (Input the shop number)."
        shopList.each do |shop|
          puts "#{shopCount}: #{shop.name}"
          shopCount +=1
        end
        print "\nYour Input: "
        shops = gets.chomp.to_i
        if shops < 1 or shops > shopList.length
          puts "You don't have that many shops.."
        else
          puts "\nHow many shelves would you like to build?"
          print "\nYour Input: "
          numShelves = gets.chomp.to_i
          if numShelves <= 0
            print "\nI won't make any shelves, then."
          else
            numShelves.times { shopList[shops-1].shelves.push(Shelf.new) }
            puts "\nNice! I made #{numShelves} shelves for you."
          end
        end
      end

  when 2
    # Remove a Shelf from a shop. COMPLETED
    shopCount = 1
    shelfCount = 1
    if shopList.length <= 0
      puts "\nYou don't have any shops. You can create one in the main menu."
    else
      puts "\nYou currently have #{shopList.length} shops. Select a shop to build shelves in. (Input the shop number)."
      shopList.each do |shop|
        puts "#{shopCount}: #{shop.name}"
        shopCount += 1
      end
      print "\nYour Input: "
      shops = gets.chomp.to_i
      if shops < 1 or shops > shopList.length
        puts "You don't have that many shops.."
      else
        puts "\n#{shopList[shops-1].name} has #{shopList[shops-1].shelves.length} shelves. Which shelf would you like to remove?"
          shopList[shops-1].shelves.each do |shelf|
            print "\nShelf #{shelfCount}: "
            shelf.candies.each { |candy| print "#{candy.name}, "}
            print "(#{shelf.candies.length} candies in total)."
            shelfCount += 1
          end
        print "\nYour Input: "
        shelves = gets.chomp.to_i
        if shelves < 1 or shelves > shopList[shops-1].shelves.length
          puts "#{shopList[shops-1]} doesn't have that many shelves."
        else
          shopList[shops-1].shelves.delete_at(shelves-1)
          puts "\nI successfully deleted Shelf #{shelves} for you."
        end
      end
    end

  else
    puts "\nI didn't understand that."
  end

when 3
  # Create, Add, or Remove candies. COMPLETED
  puts "\n1: Create Candies \n2: Add a Candy to a Shelf \n3: Remove a Candy from a Shelf \n4: Remove an Unshelved Candy from Shop"
  print "\nYour Input: "
  input = gets.chomp.to_i
  case input
  when 1
    # Create candies. COMPLETED
    candyCount = 0
    if shopList.length <= 0
      puts "\nYou don't currently have any shops. Create one in the main menu."
    else
      shopCount = 1
      puts "\nYou currently have #{shopList.length} shops. Select a shop to add candies to (Input the shop number)."
      shopList.each do |shop|
        puts "#{shopCount}: #{shop.name}"
        shopCount +=1
      end
      print "\nYour Input: "
      shops = gets.chomp.to_i
      if shops < 1 or shops > shopList.length
        puts "You don't have that many shops.."
      else
      puts "\nList all of the candies you'd like to make (Separate each candy with a comma)."
      print "\nYour Input: "
      candy = gets.chomp.split(",")
        if candy.length <= 0
          puts "\nI won't make any candies for you then."
        else
          puts "\nAlright! #{shopList[shops-1].name} now has: "
          while candyCount < candy.length
            shopList[shops-1].unshelvedCandies.push(Candy.new(candy[candyCount]))
            print "#{shopList[shops-1].unshelvedCandies[candyCount].name}, "
            candyCount += 1
          end
          print "(#{candy.length} in total).\n"
        end
      end
    end

  when 2
    # Add a candy to a shelf. COMPLETED
    shelfCount = 1
    if shopList.length <= 0
      puts "\nYou don't currently have any shops. Create one in the main menu."
    else
      shopCount = 1
      puts "\nYou currently have #{shopList.length} shops. Select a shop to add a candy to. (Input the shop number.)"
      shopList.each do |shop|
        puts "#{shopCount}: #{shop.name}"
        shopCount +=1
      end
      print "\nYour Input: "
      shops = gets.chomp.to_i
      if shops < 1 or shops > shopList.length
        puts "\nYou don't have that many shops.."
      elsif shopList[shops-1].shelves.length <= 0
        puts "\n#{shopList[shops-1].name} doesn't have any shelves."
      elsif shopList[shops-1].unshelvedCandies.length <= 0
        puts "\n#{shopList[shops-1].name} doesn't have any unshelved candies."
      else
        puts "\nYour Shelves:  "
        shopList[shops-1].shelves.each do |shelf|
          puts "\nShelf #{shelfCount}: "
          shelf.candies.each { |candy| print "#{candy.name}, "}
          print "(#{shelf.candies.length} candies in total.)\n"
          shelfCount += 1
        end
        puts "\nSelect a shelf you would like to add a candy to."
        print "\nYour Input: "
        shelves = gets.chomp.to_i
        if shelves < 1 or shelves > shopList[shops-1].shelves.length
          puts "You don't have that many shelves.."
        else
          candyCount = 1
          puts "\nYour unshelved candies: "
          shopList[shops-1].unshelvedCandies.each do |candy|
            puts "#{candyCount}: #{candy.name} "
            candyCount += 1
          end
          puts "\nSelect the candy you want to add. (Input the number of the candy.)"
          print "\nYour Input: "
          candy = gets.chomp.to_i
          if candy < 1 or candy > shopList[shops-1].unshelvedCandies.length
            puts "\nYou don't have that many candies."
          else
            puts "\n#{shopList[shops-1].unshelvedCandies[candy-1].name} was successfully added to Shelf #{shelfCount}."
            shopList[shops-1].unshelvedCandies[candy-1].isShelved = true
            shopList[shops-1].shelves[shelves-1].candies.push(shopList[shops-1].unshelvedCandies[candy-1])
            shopList[shops-1].unshelvedCandies.delete_at(candy-1)
          end
      end
    end
  end

when 3
  # Remove a candy from a shelf. COMPLETED
  shelfCount = 1
  if shopList.length <= 0
    puts "\nYou don't currently have any shops. Create one in the main menu."
  else
    shopCount = 1
    puts "\nYou currently have #{shopList.length} shops. Select a shop to remove a candy from. (Input the shop number.)"
    shopList.each do |shop|
      puts "#{shopCount}: #{shop.name}"
      shopCount +=1
    end
    print "\nYour Input: "
    shops = gets.chomp.to_i
    if shops < 1 or shops > shopList.length
      puts "\nYou don't have that many shops.."
    elsif shopList[shops-1].shelves.length <= 0
      puts "\n#{shopList[shops-1].name} doesn't have any shelves."
    else
      puts "\nYour candies: "
      shopList[shops-1].shelves.each do |shelf|
        shelf.candies.each { |candy| puts "#{candy.name} in: Shelf #{shelfCount}"}
        shelfCount += 1
      end
      puts "\nSelect a shelf you would like a remove a candy from."
      print "\nYour Input: "
      shelves = gets.chomp.to_i
      if shelves < 1 or shelves > shopList[shops-1].shelves.length
        puts "You don't have that many shelves.."
      else
        candyCount = 1
        puts "\nShelf #{shelves}: "
        shopList[shops-1].shelves[shelves-1].candies.each do |candy|
          puts "#{candyCount}: #{candy.name} "
          candyCount += 1
        end
        puts "\nSelect the candy you want to remove. (Input the number of the candy.)"
        print "\nYour Input: "
        candy = gets.chomp.to_i
        if candy < 1 or candy > shopList[shops-1].shelves[shelves-1].candies.length
          puts "\nYou don't have that many candies."
        else
          puts "\n#{shopList[shops-1].shelves[shelves-1].candies[candy-1].name} was successfully removed from the shelf."
          shopList[shops-1].shelves[shelves-1].candies[candy-1].isShelved = false
          shopList[shops-1].unshelvedCandies.push(shopList[shops-1].shelves[shelves-1].candies[candy-1])
          shopList[shops-1].shelves[shelves-1].candies.delete_at(candy-1)
        end
    end
  end
end


when 4
    # Remove an unshelved candy from a shop. COMPLETED
  if shopList.length <= 0
    puts "\nYou don't have any shops. You can create one in the main menu."
  else
    shopCount = 1
    puts "\nYou currently have #{shopList.length} shops. Select a shop (Input the shop number)."
    shopList.each do |shop|
      puts "#{shopCount}: #{shop.name}"
      shopCount +=1
    end
    print "\nYour Input: "
    shops = gets.chomp.to_i
    if shops < 1 or shops > shopList.length
      puts "You don't have that many shops.."
    elsif shopList[shops-1].unshelvedCandies.length <= 0
      puts "\n#{shopList[shops-1].name} doesn't have any unshelved candies."
    else
      candyCount = 1
      puts "\n#{shopList[shops-1].name} has unshelved candies: "
      shopList[shops-1].unshelvedCandies.each do |candy|
        puts "#{candyCount}: #{candy.name}"
        candyCount += 1
      end
      puts "\nSelect the candy you want to remove. (Input the number of the candy.)"
      print "\nYour Input: "
      candy = gets.chomp.to_i
      if candy < 1 or candy > shopList[shops-1].unshelvedCandies.length
        puts "\nYou don't have that many candies."
      else
        puts "\n#{shopList[shops-1].unshelvedCandies[candy-1].name} was successfully removed from #{shopList[shops-1].name}."
        shopList[shops-1].unshelvedCandies.delete_at(candy-1)
      end
    end
  end

else
  puts "\nI didn't understand that."
end

when 4
  # View Shelves. COMPLETED
  shelfCount = 1
  if shopList.length <= 0
    puts "\nYou don't currently have any shops. You can create one in the main menu."
  else
    shopCount = 1
    puts "\nYou currently have #{shopList.length} shops. Select a shop you'd like to view. (Input the shop number.)"
    shopList.each do |shop|
      puts "#{shopCount}: #{shop.name}"
      shopCount +=1
    end
    print "\nYour Input: "
    shops = gets.chomp.to_i
    if shops < 1 or shops > shopList.length
      puts "You don't have that many shops.."
    elsif shopList[shops-1].shelves.length <= 0
      puts "#{shopList[shops-1]} doesn't have any shelves."
    else
      puts "\n#{shopList[shops-1].name} has #{shopList[shops-1].shelves.length} shelves."
      shopList[shops-1].shelves.each do |shelf|
        print "\nShelf #{shelfCount} has candies: "
        shelf.candies.each { |candy| print "#{candy.name}, "}
        print "(#{shelf.candies.length} candies in total)."
        shelfCount += 1
      end
      puts "\n"
    end
  end

when 5
  # View candies. COMPLETED
  if shopList.length <= 0
    puts "\nYou don't have any stores. You can create one in the main menu."
  else
    puts "\nYour candies: \n"
    shopList.each do |shop|
      puts "\nIn store #{shop.name}: "
      shop.shelves.each do |shelf|
        shelf.candies.each { |candy| puts "#{candy.name} (Shelved = #{candy.isShelved})" }
      end
      if shop.unshelvedCandies.length > 0
        shop.unshelvedCandies.each { |candy| puts "#{candy.name} (Shelved = #{candy.isShelved})" }
      end
    end
  end



when 6
  done = true

else
  puts "\nI didn't quite understand that. Can you try again?"
end
end
