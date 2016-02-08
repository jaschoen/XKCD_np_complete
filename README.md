This is a solution to the xkcd comic "My hobby: embedding NP-complete problems in restaurant orders", available at http://xkcd.com/287/

# To run program:
	From base directory, type ruby lib/menu/start.rb <file>
	Example: to run the xkcd.txt menu from source_menus folder
		ruby lib/menu/start.rb xkcd

# To use a different menu: 
	-Put the name.txt file into the source_menus directory
	-Run the program passing the new name 
		Example: ruby lib/menu/start.rb name

# To run specs:
	Type Rspec from main directory

# To do list:
	-Convert to rails app
	-separate output methods and business logic to distinct classes
	-More specs, better specs, DRYer specs

