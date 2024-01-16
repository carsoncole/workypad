FactoryBot.define do
  factory :note do
    job
    content { Faker::Lorem.paragraph(sentence_count: 10)}
    category { Note.categories.pluck(0)[rand(Note.categories.size)] }

    factory :general_note do
      category { 'general' }
    end

    factory :applied_note do
      category { 'applied' }
    end

    factory :interviewed_note do
      category { 'interviewed' }
    end

    factory :archived_note do
      category { 'archived' }
    end

    factory :emailed_note do
      category { 'emailed' }
    end

    factory :tested_note do
      category { 'tested' }
    end

    factory :accepted_note do
      category { 'accepted' }
    end
  end
end
