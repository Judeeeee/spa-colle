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

    factory :checked_in_facility do
      name { "本日既にチェックインしている施設" }
      latitude { 35.7071868 }
      longitude { 139.7529042 }
      association :ward, factory: :bunkyo_ward
    end

    factory :previous_day_checked_in_facility do
      name { "昨日チェックインしている施設" }
      latitude { 35.7129856 }
      longitude { 139.7926897 }
      association :ward, factory: :taito_ward
    end
  end
end
