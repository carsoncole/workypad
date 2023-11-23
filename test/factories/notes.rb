FactoryBot.define do
  factory :note do
    job
    content { Faker::Lorem.paragraph(sentence_count: 10) }
  end
end
