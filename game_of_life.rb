class Grid
  attr_reader :cells
  DEAD = 0
  ALIVE = 1

  def initialize(row, column)
    @cells = []
    row.times do |row_index|
      column.times do |column_index|
        @cells << Cell.new(row_index, column_index, DEAD)
      end
    end
  end

  def ressurect_cell(row, column)
    @cells.find {|cell| cell.x == row && cell.y == column }.value = ALIVE
  end

  def cell_alive?(row, column)
    @cells.find {|cell| cell.x == row && cell.y == column }.value == ALIVE
  end

  def next
    new_grid = []
    @cells.each do |cell|
      neighbors = find_neighbors(cell)
      alive_count = 0
      neighbors.each do |neighbor|
        alive_count += 1 if cell_alive?(neighbor.y, neighbor.x)
      end
      if alive_count < 2
        new_grid << Cell.new(cell.y, cell.x, DEAD)
      elsif (alive_count >= 2) && (alive_count <= 3)
        new_grid << Cell.new(cell.y, cell.x, ALIVE)
      elsif (alive_count > 3) && (cell.value == ALIVE)
        new_grid << Cell.new(cell.y, cell.x, DEAD)
      elsif  (alive_count == 3) && (cell.value == DEAD)
        new_grid << Cell.new(cell.y, cell.x, ALIVE)
      else
        new_grid << Cell.new(cell.y, cell.x, DEAD)
      end
    end
    @cells = new_grid
  end

  private

  def find_neighbors(cell)
    neighbors = []

    neighbors << right_neighbor(cell.y,cell.x)
    neighbors << left_neighbor(cell.y,cell.x)
    neighbors << top_neighbor(cell.y,cell.x)
    neighbors << bottom_neighbor(cell.y,cell.x)
    neighbors << bottom_right_neighbor(cell.y, cell.x)
    neighbors << bottom_left_neighbor(cell.y, cell.x)
    neighbors << top_left_neighbor(cell.y, cell.x)
    neighbors << top_right_neighbor(cell.y, cell.x)

    neighbors.select { |neighbor| neighbor != nil}
  end

  def right_neighbor(row, column)
    @cells.find {|cell| (cell.x == column + 1) && (cell.y == row)}
  end

  def left_neighbor(row, column)
    @cells.find {|cell| (cell.x == column - 1) && (cell.y == row)}
  end

  def top_neighbor(row, column)
    @cells.find {|cell| (cell.x == column) && (cell.y == row + 1)}
  end

  def bottom_neighbor(row, column)
    @cells.find {|cell| (cell.x == column) && (cell.y == row - 1)}
  end

  def bottom_right_neighbor(row, column)
    @cells.find {|cell| (cell.x == column + 1) && (cell.y == row - 1)}
  end

  def bottom_left_neighbor(row,column)
    @cells.find {|cell| (cell.x == column - 1) && (cell.y == row - 1)}
  end

  def top_right_neighbor(row, column)
    @cells.find {|cell| (cell.x == column + 1) && (cell.y == row + 1)}
  end

  def top_left_neighbor(row, column)
    @cells.find {|cell| (cell.x == column - 1) && (cell.y == row + 1)}
  end

end

class Game
  def initialize(row, column)
    @grid = Grid.new(row, column)
  end

  def next
    @grid.next
  end
end

class Cell
  attr_accessor :x, :y, :value

  def initialize(x, y, value)
    @x = x
    @y = y
    @value = value
  end
end
