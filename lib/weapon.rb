class Weapon
  attr_reader :name, :damage, :bot
  @bot = nil

  def initialize(name, damage = 0)
    raise ArgumentError unless name
    raise ArgumentError unless name.class == String
    @name = name
    raise ArgumentError unless damage.class == Fixnum 
    @damage = damage
  end

  def bot=(bot)
    raise ArgumentError unless bot.class == BattleBot || bot == nil
    @bot = bot
  end

  def picked_up?
    return true if @bot
    false
  end

end