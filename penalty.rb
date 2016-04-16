class Penalty
  attr_reader :action, :reaction
  def initialize(coor)
    @action = translate(coor)
    @reaction = [rand(6), rand(4)]
    @gate = [4, 2]
  end

  def shoot
    if on_target(action) && !saved
      1
    else
      0
    end
  end

  def save
    if on_target(reaction) && !saved
      # scored
      1
    else
      # saved or missed
      0
    end
  end

  private

  def translate(coor)
    [coor/10,coor%10]
  end

  def on_target(xy)
    xy[0]<5 && xy[1]<3
  end

  def saved
    action == reaction
  end
end
