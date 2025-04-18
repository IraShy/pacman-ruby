class Screen
  def initialize
    @max_grid = 10
    @width = 4 * @max_grid + 5
    @name = 'PACMAN GAME'.freeze
    @screen_width = `tput cols`.to_i
  end

  # prints out the game name
  def header
    center('*' * @width)
    center(@name)
    center('*' * @width)
  end

  # takes the grid size as user input
  def grid_num
    header
    
    begin
      center("Let's define the grid size. Enter a number between 2 and #{@max_grid}")
      print '> '
      input = gets.chomp.to_i

      raise WrongInputError unless (2..@max_grid).include? input
    rescue WrongInputError => e
      puts e.msg
      retry
    end

    input
  end

  
  def read_coords
    puts "The grid origin (0, 0) is in the left bottom. Let's place the pacman."  
    x = take_coordinate('X', 0, GRID_NUM - 1).to_i
    puts
    y = take_coordinate('Y', 0, GRID_NUM - 1).to_i
    puts
    
    [x, y]
  end
  
  def read_face
    puts 'Where is the pacman facing?'
    begin
      puts "Enter one of NORTH, EAST, SOUTH, or WEST"
      print '> '
      f = gets.chomp.downcase
      
      raise WrongInputError unless %w[north east south west].include? f
      
    rescue WrongInputError => e
      puts e.msg
      retry
    end
    f
  end
  
  def grid(x = 0, y = 0, f = '')
    top_str = '┌───' + '┬───' * (GRID_NUM - 1) + "┐\n"
    div_str = '├───' + '│───' * (GRID_NUM - 1) + "┤\n"
    bot_str = '└───' + '┴───' * (GRID_NUM - 1) + "┘\n"
    odd_str = '│   ' + '│   ' * (GRID_NUM - 1) + "│\n"

    system 'clear'
    header

    strings = [top_str]

    (1..2 * GRID_NUM - 1).each do |i|
      strings[i] = i.odd? ? odd_str.dup : div_str
    end
    strings << bot_str

    pos_y = GRID_NUM * 2 - 1 - 2 * y
    pos_x = 4 * x + 2

    obj = case f
          when 'north', :north then '△'
          when 'south', :south then '▽'
          when 'east',  :east then  '▷'
          when 'west',  :west then  '◁'
          when '' then ' '
          end

    strings[pos_y][pos_x] = obj

    strings.each do |string|
      center(string)
    end
  end

  # prints out instructions and current position
  def footer
    puts
    puts 'MOVE:            ⬆'
    puts 'TURN LEFT:       ⬅'
    puts 'TURN RIGHT:      ➡'
    puts 'EXIT:         "ESC"'
    puts
  end

  # prints out good-bye
  def exit_game
    puts
    puts '*' * @width
    puts
    puts 'Thanks for playing!'
    puts 'Bye!'
    exit
  end

  private

    # centers a string in the terminal window
  def center(str)
    left_gap = ' ' * ((@screen_width - str.length) / 2)
    puts left_gap + str
  end

  def take_coordinate(coord, start_num, end_num)
    begin
      puts "Enter #{coord} position - any number between #{start_num} and #{end_num}:"
      print '> '

      # should be strip; if value = gets.chomp:
      # value == value.to_i.to_s returns false if input includes spaces
      value = gets.strip
      

      # doesn't work for end_num > 10
      # raise WrongInputError unless value.match?(/[#{start_num}-#{end_num}]/) && (start_num..end_num).include?(value.to_i)

      # not working, Integer(value) throws an error and quits the program
      # raise WrongInputError unless Integer(value) && (start_num..end_num).include?(value.to_i)
      
      
      raise WrongInputError unless value == value.to_i.to_s && (start_num..end_num).include?(value.to_i)

    rescue WrongInputError => e
      puts e.msg
      retry
    end
    value
  end
end
