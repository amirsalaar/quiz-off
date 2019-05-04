class User < ApplicationRecord
    has_many :quizzes, dependent: :nullify
    has_secure_password
end
