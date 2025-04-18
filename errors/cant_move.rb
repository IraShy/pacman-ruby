class CantMoveError < StandardError
  def initialize
    super("Can't move in this direction! Turn me!")
  end
end

