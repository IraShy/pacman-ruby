class Pacman
  attr_reader :placed
  def initialize
    @current_position = {}
    @movements = []
    @directions = {north: 1, east: 2, south: 3, west: 4}
    @moving_directions = {north: ['Y', 1], south: ['Y', -1], east: ['X', 1], west: ['X', -1]}
    @placed = false
  end

  def adjust_direction(num)
    num %= 4
    if num < 1
      num = 4
    end
    num
  end

  def adjust_movement(coordinate, delta)
    num = coordinate + delta
    if num > 4 || num < 0
      puts "I can't move! Turn or replace me."
      self.report
      false
      else
        true      
    end
  end

  def facing
    @current_position[:face]
  end

  def place(x, y, f)
    if ['north', 'east', 'south', 'west'].include?(f) && (0..4).include?(x) && (0..4).include?(y)
      @current_position = {X: x, Y: y, face: f}
      @movements = []
      @placed = true
    else 
      puts 'Wrong input!'
    end
  end

  def move
    facing = self.facing
    axis = @moving_directions[:"#{facing}"][0]
    delta = @moving_directions[:"#{facing}"][1]
    coordinate = @current_position[:"#{axis}"]

    if self.adjust_movement(coordinate, delta)
      @current_position[:"#{axis}"] = delta + coordinate
    end

    @movements << 'MOVE'
  end

  def left
    facing = self.facing
    @current_position[:face] = @directions.key(adjust_direction(@directions[:"#{facing}"] - 1))
    @movements << 'LEFT'
  end

  def right
    facing = self.facing
    @current_position[:face] = @directions.key(adjust_direction(@directions[:"#{facing}"] + 1))
    @movements << 'RIGHT'
  end

  def report
    puts "Reporting:"
    puts "Pacman is currently at (#{@current_position[:X]},#{@current_position[:Y]}) and facing #{@current_position[:face].upcase}"
    puts "Movements since the last placement: #{@movements}"
  end
end
