require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos, :children

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.winner == evaluator || nil
    return true if @board.over? && @board.winner != evaluator

    self.children.each do |child|
      losing_next_move = child.losing_node?(evaluator)
      return losing_next_move if losing_next_move
    end

    false
  end

  def winning_node?(evaluator)
    return true if @board.over? && @board.winner == evaluator
    return false if @board.over? && @board.winner != evaluator

    self.children.each do |child|
      winning_next_move = child.winning_node?(evaluator)
      return winning_next_move if winning_next_move
    end

    false
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
          prev_move = [i, j]
          child = TicTacToeNode.new(board_dup, next_mark, prev_move)
          children << child
        end
      end
    end
    children
  end

end
