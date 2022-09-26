class TestBoard
  attr_accessor :board, :board_printed

  def initialize(output: output)
    @board = %w[1 2 3 4 5 6 7 8 9]
    @board_printed = false
  end

  def print_board
    @board_printed = true
  end

  def mark_board(choice, marker)
    @board[choice.to_i - 1] = marker
  end
end
