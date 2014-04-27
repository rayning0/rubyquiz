require 'spec_helper'
require 'game_of_life'

describe 'Game of Life' do
  let(:world) { World.new }
  context World do

    it 'should create a new world object' do
      world.is_a?(World).should be_true
    end

    it 'should respond to proper methods' do
      world.should respond_to(:rows)
      world.should respond_to(:cols)
      world.should respond_to(:cell_grid)
      world.should respond_to(:cells)
      world.should respond_to(:live_neighbors_of)
      world.should respond_to(:randomly_populate)
      world.should respond_to(:live_cells)
    end

    it 'should create proper cell grid on initialization' do
      world.cell_grid.is_a?(Array).should be_true
      world.cell_grid.each do |row|
        row.is_a?(Array).should be_true
        row.each do |col|
          col.is_a?(Cell).should be_true
          col.alive?.should be_false
        end
      end
    end

    it 'should detect live neighbor to north' do
      world.cell_grid[0][1].should be_dead
      world.cell_grid[0][1].alive = true
      world.cell_grid[0][1].should be_alive
      world.live_neighbors_of(world.cell_grid[1][1]).count.should eq(1)
    end

    it 'should randomly populate world' do
      world.live_cells.should eq(0)
      world.randomly_populate
      world.live_cells.should_not eq(0)
    end
  end

  context Cell do
    let(:cell) { Cell.new }
    it 'should create a new cell object' do
      cell.is_a?(Cell).should be_true
    end

    it 'should respond to proper methods' do
      cell.should respond_to(:alive)
      cell.should respond_to(:alive?)
      cell.should respond_to(:dead?)
      cell.should respond_to(:dies)
    end

    it 'should initialize properly' do
      cell.alive.should be_false
      cell.x.should eq(0)
      cell.y.should eq(0)
    end
  end

  context Game do
    let(:game) { Game.new }
    it 'should create a new game object' do
      game.is_a?(Game).should be_true
    end

    it 'should respond to proper methods' do
      game.should respond_to(:world)
      game.should respond_to(:seeds)
      game.should respond_to(:tick)
    end

    it 'should initialize properly' do
      game.world.is_a?(World).should be_true
      game.seeds.is_a?(Array).should be_true
    end

    it 'should plant seeds properly' do
      game = Game.new(world, [[1, 2], [0, 2]])
      game.world.cell_grid[1][2].should be_alive
      game.world.cell_grid[0][2].should be_alive
    end
  end

  context 'Rules' do
    context 'Rule 1: Any live cell with < 2 live neighbors dies' do
      it 'Kills live cell with no neighbors' do
        game = Game.new(world, [[1, 1]])
        game.world.cell_grid[1][1].should be_alive
        game.tick
        game.world.cell_grid[1][1].should be_dead
      end

      it 'Kills live cell with 1 live neighbor' do
        game = Game.new(world, [[0, 1], [1, 1]])
        game.world.cell_grid[0][1].should be_alive
        game.world.cell_grid[1][1].should be_alive
        game.tick
        game.world.cell_grid[0][1].should be_dead
        game.world.cell_grid[1][1].should be_dead
      end
    end

    context 'Rule 2: Any live cell with 2-3 live neighbors
      lives on to next generation' do
      it 'Continues live cell with 2 live neighbors' do
        game = Game.new(world, [[0, 2], [1, 1], [2, 1]])
        game.tick
        game.world.cell_grid[1][1].should be_alive
        game.world.cell_grid[0][2].should be_dead
        game.world.cell_grid[2][1].should be_dead
      end

      it 'Continues live cell with 3 live neighbors' do
        game = Game.new(world, [[0, 2], [1, 1], [2, 1], [2, 0]])
        game.tick
        game.world.cell_grid[1][1].should be_alive
        game.world.cell_grid[0][2].should be_dead
        game.world.cell_grid[2][1].should be_alive
        game.world.cell_grid[2][0].should be_alive
      end
    end

    context 'Rule 3: Any live cell with > 3 live neighbors dies' do
      it 'Kills live cell with > 3 live neighbors' do
        game = Game.new(world, [[0, 2], [1, 1], [2, 1], [2, 0], [0, 0]])
        game.tick
        game.world.cell_grid[1][1].should be_dead
        game.world.cell_grid[0][0].should be_dead
        game.world.cell_grid[0][2].should be_dead
        game.world.cell_grid[2][1].should be_alive
        game.world.cell_grid[2][0].should be_alive
      end
    end

    context 'Rule 4: Any dead cell with exactly 3 live neighbors
      becomes alive' do
      it 'Revives dead cell with 3 live neighbors' do
        game = Game.new(world, [[0, 0], [1, 2], [2, 2]])
        game.tick
        game.world.cell_grid[1][1].should be_alive
        game.world.cell_grid[0][0].should be_dead
        game.world.cell_grid[1][2].should be_dead
        game.world.cell_grid[2][2].should be_dead
      end
    end
  end
end
