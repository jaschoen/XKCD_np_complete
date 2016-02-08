def parse_target_cost(file)
  exact_amount_to_spend = file.shift
  exact_amount_to_spend = exact_amount_to_spend.gsub(/[^0-9,.]/, "")
  exact_amount_to_spend = (exact_amount_to_spend.to_f * 100).to_i
end


def parse_menu(menu)
  parsed_menu = {}
  menu.each do |item|
    item.slice!("$")
    item = item.split(",")
    parsed_menu[item[0]]=(item[1].to_f * 100).to_i
  end
  parsed_menu
end

def build_possible_orders(menu_options, exact_amount_to_spend)
  max_item_qty = exact_amount_to_spend / menu_options.values.min
  possible_orders = Hash.new { |hash, key| hash[key] = [] }
  # initialize hash, key is order cost, value is array of possible orders at that cost
  possible_orders[0] << []
  # find permutations with items under max qty
  # for every menu item 
  menu_options.each do |item_name, item_price|
    # and every possible order in the hash
     possible_orders.to_a.each do |order_cost, orders_array|
      # fill each possible order with 1..max items 
       1.upto(max_item_qty) do |count|
         new_order_cost = order_cost + item_price * count
         # break if over amount to spend to reduce permutations
         break if new_order_cost > exact_amount_to_spend
         # store it in possible_order hash:
         # create new key value pair if key doesn't exist
         # if key does exist, add another array of that order
         possible_orders[new_order_cost] += orders_array.map { |order| order + [item_name] * count }
       end
     end
  end
  possible_orders
end

def output_welcome
  puts "Welcome!"
  puts "So you want to spend every possible cent on tasty tasty appetizers?"
  puts "Great, me too, let's get started."
  puts ""
end

def output_menu(menu)
  puts "======================================"
  menu.each do |key, value| 
    printf "%-21s $%s\n", key, sprintf('%.2f', value/100.0)
  end
  puts 
end

def output_final_choices(menu_options, exact_amount_to_spend)
  puts
  print "To spend exactly $"
  printf('%.2f', exact_amount_to_spend/100.0)
  puts " with this menu:"
  output_menu(menu_options)
  puts "You can buy..."
  sleep 1
  puts "Dun dun dun"
  sleep 1.3
end

def output_final_solutions(menu_options, exact_amount_to_spend)
  max_item_qty = exact_amount_to_spend / menu_options.values.min
  possible_orders = build_possible_orders(menu_options, exact_amount_to_spend)

  if possible_orders[exact_amount_to_spend] == []
    puts "*****************************************"
    puts "*                                       *"
    puts "*  Sorry, there are no exact solutions  *"
    puts "*                                       *"
    puts "*****************************************"
    exit
  end

  i = 1
  possible_orders[exact_amount_to_spend].each do |order|
     puts "\nSolution ##{i}"
     puts "*" * 24
     i += 1
     order.uniq.map do |item|
      print "   "
      printf("%-20s", item)
      item_count = order.select { |i| i == item }.size
      puts item_count
     end 
  end
end

def run(file)
  exact_amount_to_spend = parse_target_cost(file)
  menu_options = parse_menu(file)

  output_welcome()
  output_final_choices(menu_options, exact_amount_to_spend)
  output_final_solutions(menu_options, exact_amount_to_spend) 
end
