require 'colorize'

class WrongInputError < StandardError
  def initialize
    super('Wrong input.')
  end

  def msg
    message.colorize(:red)
  end
end
