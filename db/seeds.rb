PASSWORD = "supersecret"
Quiz.destroy_all
Question.destroy_all
Answer.destroy_all
Attempt.destroy_all
CorrectAnswer.destroy_all
User.destroy_all

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  role: 3
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
    total_points: rand(0..20_000)
  )
end

users = User.all

50.times do
  created_at = Faker::Date.backward(365 * 5)
  quiz = Quiz.create(
    title: Faker::TvShows::Simpsons.location,
    description: Faker::TvShows::Simpsons.quote,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
    quiz.questions = rand(0..10).times.map do
      question = Question.create(
          body: Faker::GreekPhilosophers.quote
        )
    end

end

quizzes = Quiz.all

questions = Question.all

questions.each do |q|
    q.answers = 4.times.map do
        Answer.create(
            body: Faker::ProgrammingLanguage.name
        )
    end
end

answers = Answer.all

puts Cowsay.say("Generated #{ quizzes.count } quizzes", :ghostbusters)
puts Cowsay.say("Generated #{ questions.count } questions", :dragon)
puts Cowsay.say("Generated #{ answers.count } answers", :stegosaurus)
puts Cowsay.say("Generated #{ users.count } users", :beavis)
puts Cowsay.say("Login with #{ super_user.email } and password: #{PASSWORD}", :koala)
