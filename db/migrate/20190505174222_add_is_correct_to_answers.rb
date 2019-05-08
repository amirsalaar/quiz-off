class AddIsCorrectToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :is_correct, :boolean, :default => false
  end
end
