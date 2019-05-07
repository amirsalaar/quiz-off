# frozen_string_literal: true

PASSWORD = 'supersecret'
Question.destroy_all
Answer.destroy_all
Attempt.destroy_all
User.destroy_all
Quiz.destroy_all

super_user = User.create(
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'js@winterfell.gov',
  password: PASSWORD,
  role: 1
)

10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD,
    role: rand(1..2),
    total_points: rand(0..1000)
  )
end

users = User.all
teachers = User.where(role: 1)
students = User.where(role: 2)

50.times do
  created_at = Faker::Date.backward(365 * 5)
  quiz = Quiz.create(
    title: Faker::TvShows::Simpsons.location,
    description: Faker::Hacker.say_something_smart[0..20],
    level: rand(1..3),
    points: [10, 15, 20, 30][rand(4)],
    created_at: created_at,
    updated_at: created_at,
    user: teachers.sample
  )
  5.times do
    question = Question.new(
      quiz: quiz,
      body: Faker::GreekPhilosophers.quote
    )
    question.answers << Answer.new(body: Faker::Hacker.say_something_smart[0..15], is_correct: true)
    question.save
    3.times do
      Answer.create(body: Faker::Hacker.say_something_smart[0..15], is_correct: false, question: question)
    end
  end
end

quizzes = Quiz.all

questions = Question.all

answers = Answer.all

puts "Generated #{quizzes.count} quizzes"
puts "Generated #{questions.count} questions"
puts "Generated #{answers.count} answers"
puts "Generated #{users.count} users"
puts "Login with #{super_user.email} and password: #{PASSWORD}"
