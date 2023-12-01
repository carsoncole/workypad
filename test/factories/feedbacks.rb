FactoryBot.define do
  factory :feedback do
    user { nil }
    content { "MyText" }
    status { "MyString" }
  end
end
