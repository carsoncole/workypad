include FactoryBot::Syntax::Methods

unless Source.any?
  Source::SOURCES.each do |source|
    Source.create(name: source)
  end
end

user = User.find_by_email('test@example.com') || create(:user, email: 'test@example.com', password: 'password')

20.times do
  job = create(:job,
    user: user,
    description: Faker::Lorem.paragraph,
    mode: Job.modes.pluck(0)[rand(Job.modes.size)],
    arrangement: Job.arrangements.pluck(0)[rand(Job.arrangements.size - 1) + 1],
    source: user.sources[rand(user.sources.count)],
    status: Job.statuses.pluck(0)[rand(Job.statuses.size)],
    url: Faker::Internet.url,
    primary_contact_name: Faker::Name.name,
    primary_contact_phone: Faker::PhoneNumber.phone_number,
    primary_contact_email: Faker::Internet.email,
    salary: "$#{rand(200) + 75},000"
  )
  job.notes.first.update(created_at: Time.now - (rand(50)+20).days)
end

Job.all.each do |j|
  (rand(20) + 1).times do
    note = create(:note, job: j)
    note.update(created_at: Time.now - rand(30).days)
  end
end
