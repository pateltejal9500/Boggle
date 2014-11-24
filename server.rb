require_relative './lib/solver.rb'


puts "Please type the four letters in the first row with no spaces"
row1 = gets.chomp

puts "Please type the four letters in the second row with no spaces"
row2 = gets.chomp

puts "Please type the four letters in the third row with no spaces"
row3 = gets.chomp

puts "Please type the four letters in the fourth row with no spaces"
row4 = gets.chomp

row1 = row1.split("")
row2 = row2.split("")
row3 = row3.split("")
row4 = row4.split("")


board = [row1, row2, row3, row4]
 
dictionary = File.read('./words.txt')
  dictionary_words = dictionary.split(" ")
  trie = Trie.new
  dictionary_words.each do |word|
    trie.add word
  end

  t = Board.new(board, trie).boardSolver1st()
  


