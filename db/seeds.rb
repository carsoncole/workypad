include FactoryBot::Syntax::Methods

unless Source.any?
  Source::SOURCES.each do |source|
    Source.create(name: source)
  end
end

user = create(:user, email: 'test@example.com', password: 'password')

[1..20].each do
  create_list(:job, 20, user: user, description: Faker::Lorem.paragraph)
end

Job.all.each do |j|
  create(:note, job: j)
end
