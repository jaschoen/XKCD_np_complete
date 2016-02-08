require 'spec_helper'


RSpec.describe 'XKCD methods' do 
	before :context do
  	@xkcd_file = IO.read("source_menus/xkcd.txt").split("\n")
  	@test_file = IO.read("source_menus/test.txt").split("\n")
	end

	describe '#parse_target_cost' do 
		it 'returns 1505 for xkcd.txt' do 
			file = @xkcd_file
			expect(parse_target_cost(file)).to eq(1505)
		end
		it 'returns 200 for test.txt' do 
			file = @test_file
			expect(parse_target_cost(file)).to eq(200)
		end
	end

	describe '#parse_menu(menu)' do 
		it 'returns a hash for xkcd' do
			menu_hash = {"mixed fruit"       =>215, 
								 	 "french fries"      =>275, 
							 		 "side salad"        =>335, 
									 "hot wings"         =>355, 
									 "mozzarella sticks" =>420, 
									 "sampler plate"     =>580}
			file = @xkcd_file
			expect(parse_menu(file)).to eq(menu_hash)
		end
		it 'returns a hash for test' do
			menu_hash = {"apple"=>100, "orange"=>100, "pear"=>100}
			file = @test_file
			expect(parse_menu(file)).to eq(menu_hash)
		end
	end

	describe '#build_possible_orders' do
		it 'returns correct answer for xkcd' do 
			file = IO.read("source_menus/xkcd.txt")
			file = file.split("\n")
			exact_amount_to_spend = parse_target_cost(file)
			menu_options = parse_menu(file)
			expect(build_possible_orders(menu_options, exact_amount_to_spend)[1505]).to eq([
				["mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit"], 
				["mixed fruit", "hot wings", "hot wings", "sampler plate"]])
		end
		it 'returns empty array if no solutions' do 
			file = IO.read("source_menus/xkcd.txt")
			file = file.split("\n")
			exact_amount_to_spend = parse_target_cost(file)
			menu_options = parse_menu(file)
			expect(build_possible_orders(menu_options, exact_amount_to_spend)[1]).to eq([])	
		end
		it 'returns correct answer for test solutions' do 
			file = IO.read("source_menus/test.txt")
			file = file.split("\n")
			exact_amount_to_spend = parse_target_cost(file)
			menu_options = parse_menu(file)
			expect(build_possible_orders(menu_options, exact_amount_to_spend)[200]).to eq([
				["apple", "apple"], ["orange", "orange"], ["apple", "orange"], ["pear", "pear"], 
				["apple", "pear"], ["orange", "pear"]])	
		end
		it 'returns [] for test.txt array if no solutions' do 
			file = IO.read("source_menus/test.txt")
			file = file.split("\n")
			exact_amount_to_spend = parse_target_cost(file)
			menu_options = parse_menu(file)
			expect(build_possible_orders(menu_options, exact_amount_to_spend)[1]).to eq([])	
		end
	end
end
