require_relative 'lib/pacman'
require_relative 'lib/screen.rb'
require_relative 'errors/wrong_input'
require_relative 'errors/cant_move'
require 'tty-reader'
require 'colorize'

def grid(x = 0, y = 0, f = '')
  @screen.grid(x, y, f)
  footer if @pacman.placed
end

# redraws grid and places the pacman at the current position
def end_move
  x = @pacman.current_position[:X]
  y = @pacman.current_position[:Y]
  f = @pacman.current_position[:face]
  grid(x, y, f)
end

 # prints out instructions and current position
  def footer
    @screen.footer
    @pacman.report
  end

# takes user input to place the pacman on the grid
def place_pacman(x, y, f)
  @pacman.place(x, y, f)
end

# takes a single keystroke command
def read_key
  reader = TTY::Reader.new
  key = reader.read_keypress
  case key
  when "\e"
    # "ESCAPE"
    @screen.exit_game
  when "\e[A"
    #  "UP ARROW"
    begin
      @pacman.move
      end_move
    rescue CantMoveError => e
      puts e.message.colorize(:red)
    end
  when "\e[C"
    # "RIGHT ARROW"
    @pacman.right
    end_move
  when "\e[D"
    # "LEFT ARROW"
    @pacman.left
    end_move
  end
end



system 'clear'
@screen = Screen.new
GRID_NUM = @screen.grid_num
@pacman = Pacman.new(GRID_NUM - 1)

@screen.header

grid

x, y = @screen.read_coords
f = @screen.read_face

place_pacman(x, y, f)

grid(x, y, f)

loop do
  read_key
end
