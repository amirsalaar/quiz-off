class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.text :description
      t.integer :level
      t.integer :points
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
