json.array!(@stats) do |stat|
  json.extract! stat, :id, :health, :powerType, :power, :str, :agi, :int, :sta, :crit, :haste, :mastery, :bonusArmor, :spellPower, :armor, :parry, :block, :attackPower, :mainHandDps, :rangedAttackPower
  json.url stat_url(stat, format: :json)
end
