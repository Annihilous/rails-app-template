class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string  :name
      t.string  :description
      t.integer :strength,     defaut: 1, null: false
      t.integer :dexterity,    defaut: 1, null: false
      t.integer :endurance,    defaut: 1, null: false
      t.integer :intelligence, defaut: 1, null: false
      t.integer :education,    defaut: 1, null: false
      t.integer :social,       defaut: 1, null: false

      t.timestamps
    end
  end
end
