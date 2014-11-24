require 'sinatra'
require 'pry'
require 'trie'

class Board

  def initialize(board, trie)
    @trie = trie
    @words = []
    #all the directions of movement
    @possible_directions = [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]
    @board = board
    @index_start1 = 0
    @index_start2 = 0
    @prefix = {}
    @used = Array.new(4) {[0] * 4}
  end

#this is for every letter on the board when it is the first letter
  def boardSolver1st()
    @used[@index_start1][@index_start2] = 1  
    prefix = @board[@index_start1][@index_start2]
    boardSolver2(@index_start1,@index_start2,prefix)
    move()
  end

#this will follow the prefix until it doesn't match anything in the trie
  def boardSolver2(index1, index2, prefix1)
    @possible_directions.each do |x,y|
      #making sure that the movement doesn't take you off the board
      if (0..3) === (x + index1) && (0..3) === (y + index2) 
        prefix = prefix1 + @board[x + index1][y + index2]
        if find_prefix(prefix) == true
         @prefix[prefix] = "#{x + index1}-#{y + index2}"
       end
      end 
    end
    prefixArray = []
    indexes = []
    @prefix.each do |pre, index|
     indexes << index
     prefixArray << pre
   end

   i = 0
   while i < prefixArray.length
    index = indexes[i].split("-")
    if is_word(prefixArray[i]) == true
      @words << prefixArray[i]
    end
    @prefix = {}
    #if there were prefixes that can become words, it will continue going
    boardSolver2(index[0].to_i, index[1].to_i, prefixArray[i])
    i += 1
  end
end

#checking if the word is in the dictionary trie
def is_word(word)
  if @trie.has_key?(word) == true && word.length > 2 && @words.include?(word) == false
    return true
  else
    return false
  end
end

#checking if the prefix is in any word in the dictionary trie
def find_prefix(prefix)
  if @trie.children(prefix).length > 0
    return true
  else
    return false
  end
end

def words
  return @words
end

#all the different letters on the board when they have to be the starting point 
#after they have all been used, the game is over and the words are returned
def move() 
  if @used[0][1] == 0  
    @index_start1 = 0
    @index_start2 = 1
    boardSolver1st()
  elsif @used[0][2] == 0
    @index_start1 = 0
    @index_start2 = 2
    boardSolver1st()
  elsif @used[0][3] == 0
    @index_start1 = 0
    @index_start2 = 3
    boardSolver1st()
  elsif @used[0][4] == 0
    @index_start1 = 0
    @index_start2 = 4
    boardSolver1st()
  elsif @used[1][0] == 0
    @index_start1 = 1
    @index_start2 = 0
    boardSolver1st()
  elsif @used[1][1] == 0
    @index_start1 = 1
    @index_start2 = 1
    boardSolver1st()
  elsif @used[1][2] == 0
    @index_start1 = 1
    @index_start2 = 2
    boardSolver1st()
  elsif @used[1][3] == 0
    @index_start1 = 1
    @index_start2 = 3
    boardSolver1st()
  elsif @used[2][0] == 0
    @index_start1 = 2
    @index_start2 = 0
    boardSolver1st()
  elsif @used[2][1] == 0
    @index_start1 = 2
    @index_start2 = 1
    boardSolver1st()
  elsif @used[2][2] == 0
    @index_start1 = 2
    @index_start2 = 2
    boardSolver1st()
  elsif @used[2][3] == 0
    @index_start1 = 2
    @index_start2 = 3
    boardSolver1st()
  elsif @used[3][1] == 0
    @index_start1 = 3
    @index_start2 = 1
    boardSolver1st()
  elsif @used[3][2] == 0
    @index_start1 = 3
    @index_start2 = 2
    boardSolver1st()
  elsif @used[3][3] == 0
    @index_start1 = 3
    @index_start2 = 3
    boardSolver1st()
  else 
   puts words()
   puts "There are #{words().length} words!  Play again"
 end

end

end



  