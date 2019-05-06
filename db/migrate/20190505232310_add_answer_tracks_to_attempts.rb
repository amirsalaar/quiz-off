class AddAnswerTracksToAttempts < ActiveRecord::Migration[5.2]
  def change
    add_column :attempts, :answer_tracks, :integer, default: 0
  end
end
