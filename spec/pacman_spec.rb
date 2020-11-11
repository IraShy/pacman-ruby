require_relative '../lib/pacman.rb'

describe Pacman do

  it 'returns the direction it is facing' do
    @pacman = Pacman.new 
    @pacman.place(1,2,'north')
    expect(@pacman.facing).to eq('north')
  end

  it 'reports its position' do
    @pacman = Pacman.new 
      @pacman.place(1,2,'north')
    expect{@pacman.report}.to output(/#{Regexp.quote('Pacman is currently at (1,2) and facing NORTH')}/).to_stdout
  end

  describe 'turns' do
    before do
      @pacman = Pacman.new 
      @pacman.place(2,0,'north')
    end
    context 'left from north' do
      it 'faces west' do
        @pacman.left
        expect(@pacman.facing).to eq(:west)        
      end
    end
    context '2 times right from north' do
      it 'faces south' do
        @pacman.right.right
        expect(@pacman.facing).to eq(:south)
      end
    end
    context '2 times left and 3 times right from north' do
      it 'faces east' do
        @pacman.left.left.right.right.right
        expect(@pacman.facing).to eq(:east)
      end
    end
  end

  describe 'moves' do
    before do
      @pacman = Pacman.new 
    end
    context 'when inside the grid' do
      it 'moves left if facing west' do
        @pacman.place(2,0,'west')
        @pacman.move
        expect(@pacman.current_position[:X]).to eq(1)
      end
      it 'moves up if facing north' do
        @pacman.place(2,0,'north')
        @pacman.move.move.move
        expect(@pacman.current_position[:Y]).to eq(3)
      end
      it 'combines moves and turns' do
        @pacman.place(2,2,'south')
        @pacman.move.left.move.move.right.move.right.move.move
        expect(@pacman.current_position).to eq({X: 2, Y: 0, face: :west})
      end
    end
    context 'when on the edge of the grid' do
      it 'does not move right when facing east' do
        @pacman.place(4,3,'east')
        @pacman.move
        expect(@pacman.current_position).to eq({X: 4, Y: 3, face: 'east'})
      end
      it 'does not move up when facing north' do
        @pacman.place(0,4,'north')
        @pacman.move
        expect(@pacman.current_position).to eq({X: 0, Y: 4, face: 'north'})
      end
    end
  end

  describe 'placed' do
    before do
      @pacman = Pacman.new 
    end
    context 'when given valid values' do
      it 'returns correct position' do
        @pacman.place(4,3,'east')
        expect(@pacman.current_position).to eq({X: 4, Y: 3, face: 'east'})        
      end
    end
    context 'when given invalid coordinates' do
      it 'is not placed' do
        @pacman.place('a',-7,'east')
        expect(@pacman.current_position).to eq({})
      end
    end
    context 'when given invalid facing direction' do
      it 'is not placed' do
        @pacman.place(1,0,'shv')
        expect(@pacman.current_position).to eq({})
      end
    end    
  end

 
end