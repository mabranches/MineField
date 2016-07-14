require 'spec_helper'

describe MineField do
  ROW = 13
  COL = 7
  let (:zero_bombs){ (['0']*(13*7)).join.to_i 2 }
  #(0,0) is the inferior right corner
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

  subject {MineField.new(ROW, COL, nil)}

  before do
    allow(BitSetSimple).to receive(:random).and_return(bombs)
  end

  describe '#play' do
    context 'without mines' do
      before do
        allow(BitSetSimple).to receive(:random).and_return(zero_bombs)
      end


      it 'should be finished in one play' do
        expect(subject.play(0,0)).to be_truthy
        expect(subject).to be_finished
        expect(subject).to be_victory
      end
    end

    context 'with mines' do

      context 'no mine in neighbors' do
        it 'should propagate play' do
          expect(subject.play(0, 0)).to be_truthy
          expect(subject).to_not be_finished
          expect(Printer::Terminal.new(subject.board_state).to_s).
            to eq(%Q[CCCCCCC
                     11CCC11
                     .1C112.
                     .211...
                     .......
                     .......
                     .......
                     .......
                     .......
                     .......
                     .......
                     .......
                     .......
                     ].gsub(/^\s+/,''))
        end
      end

      context 'mine in neighbors' do
        it 'Click on all neighbors without bomb. Repeat to other neighbors' do
          expect(subject.play(1,0)).to be_truthy
          expect(subject).to_not be_finished
          expect(subject.clicked.value).to eq(128)
        end
      end
      context 'clicked on mine' do

        it 'should save mine position' do
          expect(subject.play(2,0)).to be_truthy
          expect(subject.bomb_clicked).to eq([2, 0])

        end

        it 'should lose game' do
          expect(subject.play(2,0)).to be_truthy
          expect(subject).to_not be_victory
          expect(subject).to  be_finished
        end
      end
    end

    context 'Invalid position' do
      it 'should return false' do
        expect(subject.play(1,10)).to be_falsy
        expect(subject.clicked.table.value).to eq(0)
      end
    end

    context 'When there is a clicked position' do
      before do
        subject.play(0,0)
      end

      it 'should return false when clicking again' do
        expect(subject.play(0,0)).to be_falsy
      end

      it 'should not change clicked table' do
        expect{subject.play(0,0)}.to_not change{subject.clicked.table.value}
      end
    end

    context 'Game finished' do
      before do
        allow(BitSetSimple).to receive(:random).and_return(zero_bombs)
        subject.play(0,0)
      end

      it 'should return false on play' do
        expect(subject.play(0,0)).to be_falsy

      end
    end
  end

  describe "#flag" do
    it 'should flag position' do
      expect{subject.flag(0,0)}.to change{subject.flags[0,0]}.from(0).to(1)
    end
  end
end
