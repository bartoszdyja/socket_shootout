require './penalty'
class Game
  attr_accessor :status, :result
  def initialize
    turn = %w(shoot save).sample
    @result = { shots: [], saves: [] }
    @status = { result: result, turn: turn, round: 1 }
  end

  def shoot(coor)
    return 'Wrong action' unless status[:turn] == 'shoot'
    result[:shots] << Penalty.new(coor).shoot
    status[:turn] = 'save'
    status.to_json
  end

  def save(coor)
    return 'Wrong action' unless status[:turn] == 'save'
    result[:saves] << Penalty.new(coor).save
    status[:turn] = 'shoot'
    status.to_json
  end

  private

  def play(action)
    status[:turn] = action == 'shoot' ? 'save' : 'shoot'
    result[action.to_sym] << rand(2)
    status.to_json
  end
end
