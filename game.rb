class Game
  attr_accessor :status, :result
  def initialize
    turn = %w(shoot save).sample
    @result = {scored: 0, saves: 0}
    @status = { result: result, turn: turn, round: 0 }
  end

  def shoot
    return 'Wrong action' unless status[:turn] == 'shoot'
    status[:round] += 1
    result[:scored] += play
    status[:turn] = 'save'
    status.to_json
  end

  def save
    return 'Wrong action' unless turn == 'save'
    self.turn = 'shoot'
    'status'
  end

  private

  def play
    rand(2)
  end
end
