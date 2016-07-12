
class BattleBot
  @@count = 0

  attr_reader :name, :health, :enemies, :weapon

  def initialize(name)
    raise ArgumentError "No name provided" if name == nil
    @name = name
    @health = 100
    @enemies = []
    @weapon = nil
    @@count += 1
  end

  def dead?
    return true if health <= 0
    false
  end

  def take_damage(damage)
    raise ArgumentError unless damage.class == Fixnum
    @health -= damage
    @health = 0 if health < 0

    @@count -= 1 if health < 1
    health
  end

  def has_weapon?
    return true if weapon
    false
  end

  def pick_up(new_weapon)
    raise ArgumentError unless new_weapon.class == Weapon
    raise ArgumentError if new_weapon.bot

    unless weapon
      @weapon = new_weapon
      new_weapon.bot = self
      new_weapon
    else
      nil
    end
  end

  def drop_weapon
    weapon.bot = nil
    @weapon = nil
  end

  def heal
    if health > 0
      @health += 10
      @health = 100 if health > 100
    end
    health
  end

  def attack(target)
    raise ArgumentError unless target.class == BattleBot
    raise ArgumentError if target.object_id == self.object_id
    raise ArgumentError unless @weapon
    target.receive_attack_from(self)
  end

  def receive_attack_from(attacker)
    raise ArgumentError unless attacker.class == BattleBot
    raise ArgumentError if attacker == self
    raise ArgumentError unless attacker.weapon
    take_damage(attacker.weapon.damage)
    enemies << attacker unless enemies.include?(attacker)
    defend_against(attacker)
  end

  def defend_against(enemy)
    raise ArgumentError unless enemy.class == BattleBot
    unless dead?
      attack(enemy) if has_weapon?
    end
  end

  def self.count
    @@count
  end


end