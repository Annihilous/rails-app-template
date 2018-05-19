FactoryGirl.define do
  factory :character do
    sequence :name do |n| "Annihilous #{n}" end
    description 'The Primal Rage'
    strength     12
    dexterity    10
    endurance    12
    intelligence  7
    education     3
    social        5
  end
end
