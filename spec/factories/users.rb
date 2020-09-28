FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "testname#{n}" }
    sequence(:password_digest) { "hogehoge" }
  end
end
