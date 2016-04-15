class Penalty
  attr_reader :xy, :reaction
  def initialize(coor)
    @xy = coor
    @reaction = rand(6) * 10 + rand(4)
  end

  def shoot
    return 'missed' unless on_target(xy)
    return 'scored' if on_target(xy) && !saved
    'saved'
  end

  def save
    return 'missed' unless on_target(reaction)
    return 'saved' if on_target(xy) && saved
    return 'let in' if on_target(reaction) && !saved
  end

  private

  def on_target(xy)
    !(xy/10>4 || xy%10>2)
  end

  def saved
    xy == reaction
  end
end
