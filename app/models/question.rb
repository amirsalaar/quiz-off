class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |answer| answer['body'].blank? }

  validates_presence_of :answers
  validates :body, presence: true
end
