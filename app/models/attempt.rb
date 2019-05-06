class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  def result
    quiz = Quiz.find(self.quiz_id)
    self.answer_tracks.to_f / (quiz.questions.count).to_f    
  end
end
