require_relative 'pacman'

system 'clear'

pacman = Pacman.new

def call_method(pacman)
  user_input = gets.chomp.downcase.split
  command = user_input[0]

  if command == 'exit'
    exit
  end

  if ['left', 'right', 'report', 'move'].include?(command) && pacman.placed
    eval('pacman.' + command)
  end

  if command == 'place'
    args = user_input[1]

    # making sure that pacman.place is only called when valid arguments are received:
    if args
      x = args.split(',')[0] 
      y = args.split(',')[1] 
      f = args.split(',')[2] 
      if x =~ /[0-4]/ && y =~ /[0-4]/ && f != nil
        command.concat("(#{x}, #{y}, '#{f}')")
        eval('pacman.' + command)
      end
    end
  end
end

loop do
  if pacman.placed
    puts
    puts 'Enter your command: left, right, move, report, place(x,y,f), or exit'
    puts
  else 
    system 'clear'
    puts 'Place the Pacman on the grid using the following format:'
    puts
    puts 'PLACE X,Y,F ,'
    puts
    puts 'where X and Y are integers from 0 to 4, and F is one of NORTH, SOUTH, EAST or WEST.'
    puts
  end
  
  call_method(pacman)
end
