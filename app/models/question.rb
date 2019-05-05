class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers, dependent: :destroy

  # We need this line for nested fields to include answers edit fields in question#edit
  accepts_nested_attributes_for :answers
end
