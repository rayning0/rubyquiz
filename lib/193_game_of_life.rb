# http://rubyquiz.strd6.com/quizzes/193-game-of-life
# See https://github.com/rayning0/game-of-life-ruby for my 2 versions: color graphics/sound & text

# the whole game board
class World
  attr_reader :grid, :rows, :cols, :cells

  def initialize(rows = 3, cols = 3)
    @rows = rows
    @cols = cols

    @grid = Array.new(rows) do |row|
              Array.new(cols) do |col|
                Cell.new(row, col)
              end
            end

    # @grid = Array.new(rows) { Array.new(cols) }
    # grid.each_with_index do |row, r|
    #   row.each_with_index do |col, c|
    #     grid[r][c] = Cell.new
    #   end
    # end

    @cells = grid.flatten
  end

  def live_cells
    cells.select { |cell| cell.alive? }
  end

  def live_neighbors_of(cell)
    live = []
    x, y = cell.x, cell.y
    neighbors = [*x - 1..x + 1].product([*y - 1..y + 1])
      .reject { |c| c == [x, y] }

    neighbors.each do |neighbor|
      x, y = neighbor[0], neighbor[1]
      next if x < 0 || x >= rows || y < 0 || y >= cols
      live << [x, y] if grid[x][y].alive?
    end

    # live_cells.each do |c|
    #   dx = (cell.x - c.x).abs
    #   dy = (cell.y - c.y).abs
    #   if dx == 1
    #     live << c if dy.between?(0, 1)
    #   elsif dy == 1
    #     live << c if dx.between?(0, 1)
    #   end
    # end

    live
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end
end

# each individual square on the board
class Cell
  attr_reader :x, :y
  attr_accessor :alive

  def initialize(x = 0, y = 0)
    @x, @y = x, y
    @alive = false
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def lives
    @alive = true
  end

  def dies
    @alive = false
  end
end

# game play, with 4 rules, for specific initial setup
class Game
  attr_reader :world, :seeds
  def initialize(world = World.new, seeds = [])
    @world = world
    @seeds = seeds
    seeds.each do |seed|
      world.grid[seed.first][seed.last].lives
    end
  end

  def tick
    next_dead_cells, next_live_cells = [], []

    world.cells.each do |cell|
      neighbors = world.live_neighbors_of(cell).count
      if cell.alive?
        # Rule 1
        next_dead_cells << cell if neighbors < 2
        # Rule 2
        next_live_cells << cell if neighbors.between?(2, 3)
        # Rule 3
        next_dead_cells << cell if neighbors > 3
      else
        # Rule 4
        next_live_cells << cell if neighbors == 3
      end
    end

    next_dead_cells.each { |cell| cell.dies }
    next_live_cells.each { |cell| cell.lives }
  end
end
