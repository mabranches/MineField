require 'spec_helper'

describe MineField do

  let (:zero_bombs){
    (['0']*(13*7)).join.to_i 2

  }

  let (:bombs){
    [
      '0','0','0','0','0','0','0',
      '0','0','0','0','0','0','0',
      '1','0','0','0','0','0','0',
      '0','1','0','0','1','0','0',
      '0','1','0','0','0','1','0',
      '0','0','0','0','0','0','0',
      '0','0','0','1','0','0','0',
      '1','0','0','0','0','0','0',
      '0','0','0','0','0','1','0',
      '0','0','1','0','0','0','0',
      '1','0','0','0','0','0','1',
      '0','0','0','0','0','0','0',
      '0','0','0','0','0','0','0',
    ].join.to_i 2
  }

  describe '#play' do
    subject {MineField.new(13, 7, nil)}
    context 'without mines' do
      before do
        allow_any_instance_of(BitSetSimple).
          to receive(:set_random).and_return(bombs)
      end

      it 'should be finished in one play' do
        expect(subject.play(0,0)).to be_truthy
        expect(subject).to be_finished
        expect(subject).to be_won
      end
    end

    context 'with mines' do
      before do
        allow_any_instance_of(BitSetSimple).
          to receive(:set_random).and_return(bombs)
      end

      context 'no mine in neighbors' do
        it 'should propagate play' do
          expect(subject.play(0,0)).to be_truthy
          expect(subject).to_not be_finished

        end
      end

      context 'mine in neighbors' do
        it '' do
          expect(subject.play(1,0)).to be_truthy
          expect(subject).to_not be_finished
          byebug
          expect(subject.clicked).to eq(1)
        end
      end
      context 'clicked on mine' do

      end

    end
  end

end
