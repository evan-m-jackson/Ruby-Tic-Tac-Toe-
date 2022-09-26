class CPUChoice
  attr_reader :game_over

  def initialize(game_over)
    @game_over = game_over
    @ai = 'O'
    @human = 'X'
  end

  def cpu_pick(board)
    if get_available_spots(board).length > 0
      pick = if get_available_spots(board).length == 8
               cpu_first_pick(board)
             else
               best_move_to_make(board).to_s
             end
      board[pick.to_i - 1] = 'O'
    end
  end

  def get_available_spots(board)
    available = []
    board.each_with_index do |_spot, idx|
      available << idx if board[idx] != @ai && board[idx] != @human
    end
    available
  end

  def cpu_first_pick(board)
    if board[4] == '5'
      '5'
    else
      '9'
    end
  end

  def best_move_to_make(board)
    best_score = -10_000
    best_move = 0
    available = get_available_spots(board)

    return 0 if available.length == 0

    available.each do |i|
      board[i] = @ai
      score = minimax(false, board)
      board[i] = (i + 1).to_s
      if score > best_score
        best_score = score
        best_move = i
      end
    end
    best_move + 1
  end

  def minimax(isMaximizing, board)
    if @game_over.which_player_wins(board) == @ai
      return 10
    elsif @game_over.which_player_wins(board) == @human
      return -10
    elsif @game_over.is_game_over(board)
      return 0
    end

    if isMaximizing
      available = get_available_spots(board)
      best_score = -1000
      available.each do |i|
        board[i] = @ai
        score = minimax(false, board)
        board[i] = (i + 1).to_s
        best_score = [best_score, score].max
      end

    else
      available = get_available_spots(board)
      best_score = 1000
      available.each do |i|
        board[i] = @human
        score = minimax(true, board)
        board[i] = (i + 1).to_s
        best_score = [best_score, score].min
      end
    end
    best_score
  end
end
