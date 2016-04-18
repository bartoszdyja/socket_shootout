require './server'

describe Game do
  before :each do
    @game = Game.new
  end

  describe 'initialization' do
    it 'sets players order randomly' do
      expect(@game.status[:turn]).to eq('save').or eq('shoot')
    end

    it 'sets default result to [0:0]' do
      expect(@game.status[:score]).to eq [0, 0]
    end

    it 'calculates current round' do
      expect(@game.status[:round]).to eq 1
      @game.status[:turn] = 'shoot'
      @game.shoot(12)
      expect(@game.status[:round]).to eq 1
      @game.save(12)
      expect(@game.status[:round]).to eq 1
      @game.shoot(12)
      expect(@game.status[:round]).to eq 2
    end

    it 'return warning when action is not correct' do
      @game.status[:turn] = 'shoot'
      response = @game.save(12)
      expect(response).to eq 'Wrong action'
    end

    it 'return warning when action is not correct' do
      @game.status[:turn] = 'save'
      response = @game.shoot(12)
      expect(response).to eq 'Wrong action'
    end

  end
end
