FactoryBot.define do
  factory :facility do
    association :ward
    name { "施設名" }
    latitude { 35.698137 }
    longitude { 139.767935 }
  end
end
