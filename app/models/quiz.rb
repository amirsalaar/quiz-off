class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy

  validates(:title, presence: true)

  validates(
    :description, presence: { message: "Please enter a description"},
        length: { minimum: 10}
  )

  validates(:level, presence: true)

end
