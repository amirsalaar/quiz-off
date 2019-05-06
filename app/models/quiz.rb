class Quiz < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy
  has_many :takers, through: :attempts, source: :user

  validates(:title, presence: true)

  validates(
    :description, presence: { message: "Please enter a description"},
        length: { minimum: 10}
  )

  validates(:level, presence: true)

  def set_default_points
    self.points ||= 0
  end

end
