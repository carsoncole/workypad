include FactoryBot::Syntax::Methods

unless Source.any?
  Source::SOURCES.each do |source|
    Source.create(name: source)
  end
end

user = User.find_by_email('test@example.com') || create(:user, email: 'test@example.com', password: 'password')

20.times do
  create(:job,
    user: user,
    description: Faker::Lorem.paragraph,
    mode: Job.modes.pluck(0)[rand(Job.modes.size)],
    arrangement: Job.arrangements.pluck(0)[rand(Job.arrangements.size - 1) + 1],
    source: Source.find(rand(Source.count) + 1),
    status: Job.statuses.pluck(0)[rand(Job.statuses.size)],
    url: Faker::Internet.url
    )
end

Job.all.each do |j|
  (rand(20) + 1).times do
    create(:note, job: j)
  end
end
