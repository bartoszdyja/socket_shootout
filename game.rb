class Game
  attr_reader :status, :turn
  def initialize
    @turn = %w(shoot save).sample
    @status = {result: 0, turn: @turn, id: self.__id__}
  end
end
