class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  validates(
    :body, presence: { message: "Must enter an answer"},
        length: { minimum: 10}
  )
end
