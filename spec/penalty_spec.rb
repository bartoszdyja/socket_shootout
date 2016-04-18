require './penalty'

describe Penalty do
  describe 'initialization' do
    before do
      @penalty = Penalty.new(12)
    end
    it 'sets default goal size' do
      expect(@penalty.gate[:width]).to eq 4
      expect(@penalty.gate[:height]).to eq 2
    end

    it 'translate coordinates to array' do
      expect(@penalty.player).to eq [1, 2]
    end

    it 'recognized successful shot' do
      penalty = Penalty.new(11)
      allow(penalty).to receive(:computer) { [1, 2] }
      expect(penalty.shoot).to eq 1
    end

    it 'recognized missed shot' do
      penalty = Penalty.new(43)
      allow(penalty).to receive(:computer) { [1, 2] }
      expect(penalty.shoot).to eq 0
    end

    it 'recognized shot saved by computer' do
      penalty = Penalty.new(12)
      allow(penalty).to receive(:computer) { [1, 2] }
      expect(penalty.shoot).to eq 0
    end

    it 'recognized let in shot' do
      penalty = Penalty.new(11)
      allow(penalty).to receive(:computer) { [1, 2] }
      expect(penalty.save).to eq 1
    end

    it 'recognized saved shot' do
      penalty = Penalty.new(11)
      allow(penalty).to receive(:computer) { [1, 1] }
      expect(penalty.save).to eq 0
    end

    it 'recognized overshoot shot' do
      penalty = Penalty.new(11)
      allow(penalty).to receive(:computer) { [4, 3] }
      expect(penalty.save).to eq 0
    end

  end
end
