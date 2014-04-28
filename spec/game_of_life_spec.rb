require 'spec_helper'
require 'game_of_life'

describe 'Game of Life' do
  describe World do
    let(:world) { World.new }
    it 'has these methods' do
      expect(world).to respond_to(:rows)
      expect(world).to respond_to(:cols)
      expect(world).to respond_to(:grid)
      expect(world).to respond_to(:cells)
      expect(world).to respond_to(:live_cells)
      expect(world).to respond_to(:live_neighbors_of)
      expect(world).to respond_to(:randomly_populate)
    end

    it 'creates a 2-D array of arrays, a grid of Cell objects' do
      expect(world.grid.is_a?(Array)).to be_true
      world.cells.each do |cell|
        expect(cell.is_a?(Cell)).to be_true
        expect(cell.alive?).to be_false
      end
    end

    it 'makes grid with x, y coordinates matching its row, col' do
      world.rows.times do |row|
        world.cols.times do |col|
          cell = world.grid[row][col]
          expect(cell.x).to eq(row)
          expect(cell.y).to eq(col)
        end
      end
    end

    describe '#live_cells' do
      it 'finds all live cells in a world' do
        cell1 = world.grid[1][1]
        cell2 = world.grid[0][0]
        cell3 = world.grid[1][2]
        cell4 = world.grid[1][0]
        cell1.lives
        cell2.lives
        cell3.lives
        cell4.lives
        expect(world.live_cells.count).to eq(4)
      end
    end

    describe '#live_neighbors_of' do
      it 'finds live neighbors of a cell' do
        cell1 = world.grid[1][1]
        cell2 = world.grid[0][0]
        cell3 = world.grid[1][2]
        cell4 = world.grid[1][0]
        expect(cell1.dead?).to be_true
        cell1.lives
        cell2.lives
        cell3.lives
        cell4.lives
        expect(world.live_neighbors_of(cell1).count).to eq(3)
        expect(world.live_neighbors_of(cell2).count).to eq(2)
        expect(world.live_neighbors_of(cell3).count).to eq(1)
        expect(world.live_neighbors_of(cell4).count).to eq(2)
      end
    end

    describe '#randomly_populate' do
      it 'makes world of randomly alive/dead cells' do
        expect(world.live_cells.count).to eq(0)
        world.randomly_populate
        expect(world.live_cells.count).to be > 0
      end
    end
  end

  describe Cell do
    let(:cell) { Cell.new }
    it 'has these methods' do
      expect(cell).to respond_to(:alive)
      expect(cell).to respond_to(:alive?)
      expect(cell).to respond_to(:dead?)
      expect(cell).to respond_to(:lives)
      expect(cell).to respond_to(:dies)
    end

    it 'should initialize properly' do
      expect(cell.alive?).to be_false
      expect(cell.x).to eq(0)
      expect(cell.y).to eq(0)
    end

    it 'checks if cell is alive or dead' do
      expect(cell.dead?).to be_true
    end

    it 'can set a cell to live or die' do
      cell.lives
      expect(cell.alive?).to be_true
      expect(cell.dead?).to be_false

      cell.dies
      expect(cell.dead?).to be_true
      expect(cell.alive?).to be_false
    end
  end

  describe Game do
    let(:game) { Game.new }
    let(:world) { World.new }
    it 'has these methods' do
      expect(game).to respond_to(:world)
      expect(game).to respond_to(:seeds)
      expect(game).to respond_to(:tick)
    end

    it 'initializes properly' do
      expect(game.world.is_a?(World)).to be_true
      expect(game.seeds.is_a?(Array)).to be_true
    end

    it 'creates new living Cells at right x, y coordinates' do
      game = Game.new(world, [[0, 1], [1, 1], [2, 2]])
      expect(game.world.grid[0][1]).to be_alive
      expect(game.world.grid[1][1]).to be_alive
      expect(game.world.grid[2][2]).to be_alive

      expect(game.world.grid[0][0]).to be_dead
      expect(game.world.grid[0][2]).to be_dead
    end

    context 'Rule 1: Any live cell with < 2 live neighbors dies.' do
      it 'Kills live cell with 0 live neighbors' do
        game = Game.new(world, [[1, 1]])
        game.tick
        expect(game.world.grid[1][1]).to be_dead
      end

      it 'Kills live cell with 1 live neighbor' do
        game = Game.new(world, [[0, 1], [1, 1]])
        game.tick
        expect(game.world.grid[1][1]).to be_dead
        expect(game.world.grid[0][1]).to be_dead
      end
    end

    context 'Rule 2: Any live cell with 2-3 live neighbors lives\
      on to next generation.' do
      it 'Continues live cell with 2 live neighbors' do
        game = Game.new(world, [[0, 2], [1, 1], [2, 1]])
        game.tick
        expect(game.world.grid[1][1]).to be_alive
        expect(game.world.grid[0][2]).to be_dead
        expect(game.world.grid[2][1]).to be_dead
      end

      it 'Continues live cell with 3 live neighbors' do
        game = Game.new(world, [[0, 2], [1, 1], [2, 1], [2, 0]])
        game.tick
        expect(game.world.grid[1][1]).to be_alive
        expect(game.world.grid[0][2]).to be_dead
        expect(game.world.grid[2][1]).to be_alive
        expect(game.world.grid[2][0]).to be_alive
      end
    end

    context 'Rule 3: Any live cell with > 3 live neighbors dies.' do
      it 'Kills live cell with > 3 live neighbors' do
        game = Game.new(world, [[0, 2], [1, 1], [2, 1], [2, 0], [0, 0]])
        game.tick
        expect(game.world.grid[1][1]).to be_dead
        expect(game.world.grid[0][0]).to be_dead
        expect(game.world.grid[0][2]).to be_dead
        expect(game.world.grid[2][1]).to be_alive
        expect(game.world.grid[2][0]).to be_alive
      end
    end

    context 'Rule 4: Any dead cell with exactly 3 live neighbors\
      becomes alive.' do
      it 'Revives dead cell with 3 live neighbors' do
        game = Game.new(world, [[0, 0], [1, 2], [2, 2]])
        game.tick
        expect(game.world.grid[1][1]).to be_alive
        expect(game.world.grid[0][0]).to be_dead
        expect(game.world.grid[1][2]).to be_dead
        expect(game.world.grid[2][2]).to be_dead
      end
    end
  end
end
