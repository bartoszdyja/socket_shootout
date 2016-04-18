class Penalty
  attr_reader :player, :computer, :gate
  def initialize(coor)
    @gate = { width: 4, height: 2 }
    @player = translate(coor)
    @computer = [rand(gate[:width] + 1), rand(gate[:height] + 1)] # simulate random shots
  end

  def shoot
    on_target(player) && !saved ? 1 : 0
  end

  def save
    on_target(computer) && !saved ? 1 : 0
  end

  private

  def translate(coor)
    [coor / 10, coor % 10]
  end

  def on_target(xy)
    xy[0] <= gate[:width] && xy[1] <= gate[:height]
  end

  def saved
    player == computer
  end
end
