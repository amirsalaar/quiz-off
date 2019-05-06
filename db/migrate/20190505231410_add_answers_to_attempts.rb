class AddAnswersToAttempts < ActiveRecord::Migration[5.2]
  def change
    add_column :attempts, :answers, :integer, array: true
  end
end
