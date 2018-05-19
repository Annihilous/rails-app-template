require 'rails_helper'

RSpec.describe Character, type: :model do
  describe '#validations' do
    it 'is valid if required fields are present' do
      character = build(:character)
      expect(character).to be_valid
      expect(character.errors).to be_empty
    end

    [ #required field
      :name,
      :description,
      :strength,
      :dexterity,
      :endurance,
      :intelligence,
      :education,
      :social,
    ].each do |required_field|
      it "is invalid if #{required_field} is not present" do
        character = build(:character)
        character.send("#{required_field}=", '')
        expect(character).not_to be_valid
        expect(character.errors).to have_key(required_field)
      end

      it "is invalid if #{required_field} is set to nil" do
        character = build(:character)
        character.send("#{required_field}=", nil)
        expect(character).not_to be_valid
        expect(character.errors).to have_key(required_field)
      end
    end

    [   #unique field  #value
      [ :name,        'Annihilous' ],
    ].each do |test_case|
      unique_field, value = test_case

      it "is invalid if #{unique_field} is not unique" do
        character_1 = build(:character)
        character_1.send("#{unique_field}=", value)
        character_1.save

        character_2 = build(:character)
        character_2.send("#{unique_field}=", character_1.send(unique_field))

        expect(character_2).not_to be_valid
        expect(character_2.errors).to have_key(unique_field)
      end
    end
  end
end
