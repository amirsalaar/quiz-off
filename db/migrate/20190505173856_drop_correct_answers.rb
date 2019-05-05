class DropCorrectAnswers < ActiveRecord::Migration[5.2]
  def change
    drop_table :correct_answers 
  end
end
