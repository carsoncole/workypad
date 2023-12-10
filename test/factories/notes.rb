FactoryBot.define do
  factory :note do
    job
    content { Faker::Lorem.paragraph(sentence_count: 10)}
    category { Note.categories.pluck(0)[rand(Note.categories.size)] }
  end
end
