FactoryBot.define do
  factory :feedback do
    user
    content { "MyText" }
  end
end
