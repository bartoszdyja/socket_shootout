class Game
  attr_reader :status, :turn
  def initialize
    @turn = %w(shoot save).sample
    @status = { result: 0, turn: @turn }
  end

  def shoot
    return 'Wrong action' unless turn == 'shoot'
    'Good action'
  end
end
