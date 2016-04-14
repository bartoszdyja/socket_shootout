class Game
  attr_accessor :status, :result
  def initialize
    turn = %w(shoot save).sample
    @result = {shoot: [], save: []}
    @status = { result: result, turn: turn, round: 0 }
  end

  def shoot
    play('shoot')
  end

  def save
    play('save')
  end

  private

  def play(action)
    return 'Wrong action' unless status[:turn] == action
    status[:turn] = action == 'shoot' ? 'save' : 'shoot'
    status[:round] += 1
    result[action.to_sym] << rand(2)
    status.to_json
  end
end
