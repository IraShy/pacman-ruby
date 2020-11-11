require_relative 'pacman'

system 'clear'

pacman = Pacman.new
continue = true

def call_method(pacman)
  user_input = gets.chomp.downcase.split
  command = user_input[0]

  if ['left', 'right', 'report', 'move', 'place'].include?(command) 
    if (!pacman.placed && command == 'place') || pacman.placed
      args = user_input[1]
      if args
        x = args.split(',')[0]
        y = args.split(',')[1]
        f = args.split(',')[2]
        command.concat("(#{x}, #{y}, '#{f}')")
      end      
      eval('pacman.' + command)
    end
  end
end

loop do
  if pacman.placed
    puts
    puts 'Enter your command'
    puts
  else 
    system 'clear'
    puts 'Place the Pacman on the grid using the following format:'
    puts
    puts 'PLACE X,Y,F'
    puts 'where X and Y are integers from 0 to 4, and F is one of NORTH, SOUTH, EAST or WEST.'
  end
  
  call_method(pacman)
end
