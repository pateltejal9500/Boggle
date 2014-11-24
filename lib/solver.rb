require 'sinatra'
require 'pry'
require 'trie'

class Board

  def initialize(board, trie)
    @trie = trie
    @words = []
    @possible_directions = [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]
    @board = board
    @index_start1 = 0
    @index_start2 = 0
    @prefix = {}
    @used = Array.new(4) {[0] * 4}
  end

  def boardSolver1st()
    @used[@index_start1][@index_start2] = 1  
    prefix = @board[@index_start1][@index_start2]
    boardSolver2(@index_start1,@index_start2,prefix)
    move()
  end

  def boardSolver2(index1, index2, prefix1)
    @possible_directions.each do |x,y|
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
    boardSolver2(index[0].to_i, index[1].to_i, prefixArray[i])
    i += 1
  end
end

def is_word(word)
  if @trie.has_key?(word) == true && word.length > 2 && @words.include?(word) == false
    return true
  else
    return false
  end
end

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



  