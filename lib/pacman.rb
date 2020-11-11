class Pacman
  attr_reader :placed, :current_position
  def initialize
    @current_position = {}
    @movements = []
    @directions = {north: 1, east: 2, south: 3, west: 4}
    @moving_directions = {north: ['Y', 1], south: ['Y', -1], east: ['X', 1], west: ['X', -1]}
    @placed = false
  end

  def set_direction(num)
  # ensuring that turning right from west and left from north results in facing the correct direction

    num %= 4
    if num < 1
      num = 4
    end
    num
  end

  def facing
  # returning current facing direction
    @current_position[:face]
  end

  def place(x, y, f)
  # PLACE will put the Pacman on the grid in positon X,Y and facing NORTH,SOUTH, EAST or WEST.

    if ['north', 'east', 'south', 'west'].include?(f) && (0..4).include?(x) && (0..4).include?(y)
      @current_position = {X: x, Y: y, face: f}
      @movements = []
      @placed = true
    else 
      puts 'Wrong input!'
    end
    self
  end

  def move
  # MOVE will move Pacman one unit forward in the direction it is currently facing

    facing = self.facing
    # axis of movement (x or y), moving direction (positive or negative), and starting point:
    axis = @moving_directions[:"#{facing}"][0]
    delta = @moving_directions[:"#{facing}"][1]
    coordinate = @current_position[:"#{axis}"]

    #preventing the pacman from moving off the grid
    if coordinate + delta > 4 || coordinate + delta < 0
      puts "I can't move! Turn or replace me."
      self.report
    else
      @current_position[:"#{axis}"] = delta + coordinate
    end

    @movements << 'MOVE'
    self
  end

  # LEFT and RIGHT will rotate Pacman 90 degrees in the specified direction without changing the position of Pacman.

  def left
    facing = self.facing
    @current_position[:face] = @directions.key(set_direction(@directions[:"#{facing}"] - 1))
    @movements << 'LEFT'
    self
  end

  def right
    facing = self.facing
    @current_position[:face] = @directions.key(set_direction(@directions[:"#{facing}"] + 1))
    @movements << 'RIGHT'
    self
  end

  def report
  # REPORT will announce the X,Y and F of Pacman
    
    puts "Reporting:"
    puts "Pacman is currently at (#{@current_position[:X]},#{@current_position[:Y]}) and facing #{@current_position[:face].upcase}"
    puts "Movements since the last placement: #{@movements}"
  end
end

