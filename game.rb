require './penalty'

class Game
  attr_accessor :status, :result, :score
  def initialize
    turn = %w(shoot save).sample
    @result = { you: [], computer: [] }
    @score = { you: 0, computer: 0 }
    @status = { result: result, turn: turn, round: 1, score: @score, active: true }
  end

  def shoot(coor)
    return status.to_json unless status[:active] == true
    return 'Wrong action' unless status[:turn] == 'shoot'
    result[:you] << Penalty.new(coor).shoot
    status[:turn] = 'save'
    update_result

  end

  def save(coor)
    return status.to_json unless status[:active] == true
    return 'Wrong action' unless status[:turn] == 'save'
    result[:computer] << Penalty.new(coor).save
    status[:turn] = 'shoot'
    update_result
  end

  private

  def update_result
    status[:round] = (result[:you] && result[:computer]).size + 1
    score[:you] = result[:you].reduce(0, :+)
    score[:computer] = result[:computer].reduce(0, :+)
    if score[:you] == 3 && score[:computer] == 0
      status[:active] = false
    elsif score[:you] == 0 && score[:computer] == 3
      status[:active] = false
    elsif score[:you] == 4 && score[:computer] == 2
      status[:active] = false
    elsif score[:you] <= 2 && score[:computer] == 4
      status[:active] = false
    elsif score[:you] != score[:computer] && status[:round]>5
      status[:active] = false
    end
    status.to_json
  end
end
