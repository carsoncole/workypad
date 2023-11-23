FactoryBot.define do
  factory :job do
    entity { Faker::Company.name }
    title  { Faker::Job.title }
    url { Faker::Internet.url }
    user
  end
end
