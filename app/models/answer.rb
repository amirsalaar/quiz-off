class Answer < ApplicationRecord
  belongs_to :question
  
  validates(
    :body, presence: { message: "Must enter an answer"},
        length: { minimum: 10}
  )

end
