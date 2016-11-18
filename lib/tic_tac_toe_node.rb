require_relative 'tic_tac_toe'
require 'byebug'


class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos, :children

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |_, j|
        if @board.empty?([i, j])
          board_dup = @board.dup
          board_dup.rows[i][j] = @next_mover_mark
          next_mark = (@next_mover_mark == :x ? :o : :x)
          child = TicTacToeNode.new(board_dup, next_mark, [i, j])
          children << child
        end
      end
    end
    children
  end


end


board = Board.new
mark = :x
node = TicTacToeNode.new(board, mark)
p node.children
