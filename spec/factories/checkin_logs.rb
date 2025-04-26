FactoryBot.define do
  factory :checkin_log do
    association :user
    association :facility
    created_at { Time.zone.today }

    transient do
      days_ago { 0 } # デフォルトは今日
    end

    before(:create) do |checkin_log, evaluator|
      checkin_log.created_at = Time.zone.today - evaluator.days_ago.days
    end
  end
end
