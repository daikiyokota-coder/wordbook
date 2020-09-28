FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "testname#{n}" }
    password { 'hogehoge' }
    password_confirmation { 'hogehoge' }
  end
end
