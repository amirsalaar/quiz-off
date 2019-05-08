class CreateAttempts < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.integer :score
      t.references :user, foreign_key: true
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
