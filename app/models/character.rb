class Character < ApplicationRecord
  validates :name,
            :description,
            :strength,
            :dexterity,
            :endurance,
            :intelligence,
            :education,
            :social,
            presence: true

  validates :name,
            uniqueness: true

  def stat_bonus(stat_value)
    (stat_value / 3).round - 2
  end
end
