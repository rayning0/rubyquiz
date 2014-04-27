# http://rubyquiz.strd6.com/quizzes/193-game-of-life
# See https://github.com/rayning0/game-of-life-ruby for my 2 versions: color graphics/sound & text

require 'io/wait'

# Game of Life board
class World
  attr_accessor :rows, :cols, :cell_grid, :cells

  # Default starting world
  #------------------------
  #     0     1     2
  # 0 [ dead, dead, dead ]
  # 1 [ dead, dead, dead ]
  # 2 [ dead, dead, dead ]

  def initialize(rows = 3, cols = 3)
    @rows = rows
    @cols = cols

    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(row, col)
      end
    end

    @cells = cell_grid.flatten
  end

  def live_neighbors_of(cell)
    live = []
    neighbors = [*cell.x - 1..cell.x + 1].product([*cell.y - 1..cell.y + 1])
      .reject { |c| c == [cell.x, cell.y] }
    neighbors.each do |c|
      x, y = c[0], c[1]
      next if x < 0 || x >= rows || y < 0 || y >= cols
      live << [x, y] if cell_grid[x][y].alive?
    end
    live
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end

  def live_cells
    cells.select { |cell| cell.alive? }.count
  end
end

# individual cell
class Cell
  attr_accessor :alive, :x, :y

  def initialize(x = 0, y = 0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def dies
    self.alive = false
  end

  def lives
    self.alive = true
  end
end

# game play, with rules
class Game
  attr_accessor :world, :seeds
  def initialize(world = World.new, seeds = [])
    @world = world
    @seeds = seeds

    seeds.each do |seed|
      world.cell_grid[seed.first][seed.last].alive = true
    end
  end

  def tick
    next_live_cells, next_dead_cells = [], []

    world.cells.each do |cell|
      neighbors = world.live_neighbors_of(cell).count
      if cell.alive?
        # Rule 1
        next_dead_cells << cell if neighbors < 2
        # Rule 2
        next_live_cells << cell if neighbors.between?(2, 3)
        # Rule 3
        next_dead_cells << cell if neighbors > 3

      # Rule 4
      else next_live_cells << cell if neighbors == 3
      end
    end

    next_dead_cells.each do |cell|
      cell.dies
    end

    next_live_cells.each do |cell|
      cell.lives
    end
  end
end

# plain text output in Terminal, w/o sound
class Window
  ALIVE = "\u2751".encode('utf-8')  # white square
  DEAD = "\u2588".encode('utf-8')   # black square

  attr_reader :width, :height, :game, :dx, :dy, :cols, :rows, :title

  def initialize(width, height)
    @width, @height = width, height
    @title = "Raymond Gan's Game of Life"
    @cols, @rows = width, height
    @gen = 1

    @game = Game.new(World.new(@rows, @cols))
    @game.world.randomly_populate
  end

  def update
    game.tick
    @gen += 1
  end

  def display
    puts title.center(width * 2)
    live_cells = game.world.live_cells
    puts "Generation: #{@gen}  Live cells: #{live_cells}".center(width * 2)

    rows.times do |row|
      cols.times do |col|
        cell = game.world.cell_grid[row][col]
        text = cell.alive? ? ALIVE : DEAD
        print "#{text} "
      end
      puts
    end
  end

  def run
    loop do
      system('clear') # clears terminal screen
      display
      input = char_if_pressed

      if input == ' ' # space bar restarts game
        @gen = 0
        game.world.randomly_populate
      end

      sleep(0.05)
      update
      break if input == "\e" # ESC key quits
    end
  end

  private

  def char_if_pressed # captures background key press
    begin
      system('stty raw -echo') # turn raw input on
      c = $stdin.getc if $stdin.ready?
      c.chr if c
    ensure
      system('stty -raw echo') # turn raw input off
    end
  end
end

# run in terminal by uncommenting below line, then typing "ruby game_of_life.rb"
# Window.new(40, 30).run