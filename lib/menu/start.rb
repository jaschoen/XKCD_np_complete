# require 'menu/xkcd'
require_relative 'xkcd'
target_file = ARGV[0]
target_file = "source_menus/#{target_file}.txt"
file = IO.read(target_file)
file = file.split("\n")

run(file)