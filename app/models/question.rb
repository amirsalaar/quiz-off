class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |answer| answer['body'].blank? }

  validates_presence_of :answers
  validates :body, presence: true

  def generate_fake_answer
    3.times do 
      self.answers << Answer.new(body: Faker::Hacker.say_something_smart[0..25], is_correct: false)
    end
    self.answers
  end
end
