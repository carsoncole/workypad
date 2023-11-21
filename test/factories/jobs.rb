FactoryBot.define do
  factory :job do
    entity { "MyString" }
    title { "MyString" }
    url { "MyString" }
    description { "MyText" }
    status { 1 }
    order { 1 }
    user
  end
end
