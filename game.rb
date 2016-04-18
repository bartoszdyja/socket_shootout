require './penalty'

class Game
  attr_accessor :status, :result
  def initialize
    turn = %w(shoot save).sample
    @result = { you: [], computer: [] }
    @status = { result: result, turn: turn, round: 1, score: [0,0] }
  end

  def shoot(coor)
    return 'Wrong action' unless status[:turn] == 'shoot'
    result[:you] << Penalty.new(coor).shoot
    status[:turn] = 'save'
    update_result
  end

  def save(coor)
    return 'Wrong action' unless status[:turn] == 'save'
    result[:computer] << Penalty.new(coor).save
    status[:turn] = 'shoot'
    update_result
  end

  private

  def update_result
    status[:round] = result[:you].size
    status[:score][0] = result[:you].reduce(0,:+)
    status[:score][1] = result[:computer].reduce(0,:+)
    status.to_json
  end
end
