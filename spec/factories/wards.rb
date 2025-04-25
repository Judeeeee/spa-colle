FactoryBot.define do
  factory :ward do
    factory :chiyoda_ward do
      name { "千代田区" }
      name_kana { "ちよだく" }
    end

    factory :chuo_ward do
      name { "中央区" }
      name_kana { "ちゅうおうく" }
    end

    factory :shinjuku_ward do
      name { "新宿区" }
      name_kana { "しんじゅくく" }
    end
  end
end
