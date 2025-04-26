FactoryBot.define do
  factory :facility do
    factory :not_check_in_facility do
      name { "未チェックイン施設" }
      latitude { 35.698137 }
      longitude { 139.767935 }
      association :ward, factory: :chiyoda_ward
    end

    factory :fails_to_check_in_facility do
      name { "チェックインに失敗する施設" }
      latitude { 35.6706907 }
      longitude { 139.7599611 }
      association :ward, factory: :chuo_ward
    end

    factory :many_check_in_facility do
      name { "ページネーションが表示される施設" }
      latitude { 35.694526 }
      longitude { 139.7051388 }
      association :ward, factory: :shinjuku_ward
    end
  end
end
