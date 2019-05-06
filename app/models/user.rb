class User < ApplicationRecord
    has_many :quizzes, dependent: :nullify
    has_many :attempts, dependent: :destroy
    has_many :attempted_quizzes, through: :attempts, source: :quiz
    
    has_secure_password

    validates(:email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)

    def full_name
        "#{first_name} #{last_name}".strip
    end

    before_validation :set_default_total_points

    private

    def set_default_total_points
        self.total_points ||= 0
    end

end
