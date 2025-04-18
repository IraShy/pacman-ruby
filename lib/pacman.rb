require_relative '../errors/cant_move'

class Pacman
  attr_reader :placed, :current_position
  def initialize(grid_num)
    @grid_num = grid_num
    # @current_position = { X: 0, Y: 0, face: 'north' }
    @directions = { north: 1, east: 2, south: 3, west: 4 }
    @moving_directions = { north: ['Y', 1], south: ['Y', -1], east: ['X', 1], west: ['X', -1] }
    @placed = false
  end

  # ensures that turning right from west and left from north results in facing the correct direction
  def set_direction(num)
    num %= 4
    num = 4 if num < 1
    num
  end

  # puts the Pacman on the grid in positon X,Y and facing NORTH,SOUTH, EAST or WEST.
  def place(x, y, f)
    @current_position = { X: x, Y: y, face: f }
    @placed = true
    self
  end

  # returns current facing direction
  def facing
    @current_position[:face]
  end

  # move Pacman one unit forward in the direction it is currently facing
  def move
    facing = self.facing
    # axis of movement (x or y), moving direction (positive or negative), and starting point:
    axis = @moving_directions[:"#{facing}"][0]
    delta = @moving_directions[:"#{facing}"][1]
    coordinate = @current_position[:"#{axis}"]

    # preventing the pacman from moving off the grid
    if coordinate + delta > @grid_num || coordinate + delta < 0
      raise CantMoveError
    else
      @current_position[:"#{axis}"] = delta + coordinate
    end

    self
  end

  # LEFT and RIGHT will rotate Pacman 90 degrees in the specified direction without changing the position of Pacman.

  def left
    facing = self.facing
    @current_position[:face] = @directions.key(set_direction(@directions[:"#{facing}"] - 1))

    self
  end

  def right
    facing = self.facing
    @current_position[:face] = @directions.key(set_direction(@directions[:"#{facing}"] + 1))

    self
  end

  # announce the X,Y and F of Pacman
  def report
    puts "Pacman is currently at (#{@current_position[:X]},#{@current_position[:Y]}) and facing #{@current_position[:face].upcase}"
  end
end
