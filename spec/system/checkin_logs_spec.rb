require 'rails_helper'

RSpec.describe "CheckinLogs", type: :system do
  let!(:user) { create(:user) }

  before(:each) do
    Capybara.reset_sessions!
    driven_by :selenium_chrome_headless
    login_with_google(user)
    sleep 1 # ここで待たないとログインできていない時がある
  end

  describe "check in functionality" do
    context "when the user checks in for the first time within 200 meters of the facility" do
      let!(:chiyoda_ward) { create(:ward, name: "千代田区", name_kana: "ちよだく") }
      let!(:not_check_in_facility) { create(:facility, name: "未チェックイン施設", latitude: 35.698137, longitude: 139.767935, ward: chiyoda_ward) }

      it "successfully check in and displays first-time check-in modal" do
        visit root_path
        check_stamp_card_status(ward: "千代田区", count_text: "0 / 1")

        visit facility_path(not_check_in_facility)
        expect(page).to have_selector('h1', text: '未チェックイン施設')

        sleep 2 # ここにsleep追加しないと緯度経度がセットされない
        fill_in_location_and_submit(lat: 35.698800, lng: 139.768500) # 約100m北東

        expect(page).to have_selector('#checkin-modal-frame', visible: true, wait: 5)

        within "#checkin-modal-frame" do
          expect(page).to have_content("初回チェックイン🎉")
          click_button "閉じる"
        end

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"))

        visit root_path
        check_stamp_card_status(ward: "千代田区", count_text: "1 / 1")
      end
    end

    context "when the user has already checked in on a previous day" do
      let!(:taito_ward) { create(:ward, name: "台東区", name_kana: "たいとうく") }
      let!(:previous_day_checked_in_facility) { create(:facility, name: "昨日チェックインしている施設", latitude: 35.7129856, longitude: 139.7926897, ward: taito_ward) }

      before do
        create(:checkin_log, user: user, facility: previous_day_checked_in_facility, days_ago: 1)
      end

      it "successfully check in and redirects to the check in log page" do
        visit root_path
        check_stamp_card_status(ward: "台東区", count_text: "1 / 1")

        visit facility_path(previous_day_checked_in_facility)
        expect(page).to have_selector('h1', text: '昨日チェックインしている施設')

        fill_in_location_and_submit(lat: 35.7138849, lng: 139.7937973) # 約100m北東

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_content(Time.zone.yesterday.strftime("%Y/%m/%d"), count: 1)
        expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"), count: 1)
      end
    end

    context "when the user is more than 200 meters away from the facility" do
      let!(:chuo_ward) { create(:ward, name: "中央区", name_kana: "ちゅうおうく") }
      let!(:fails_to_check_in_facility) { create(:facility, name: "チェックインに失敗する施設", latitude: 35.6706907, longitude: 139.7599611, ward: chuo_ward) }

      it "fails to check in and displays limit modal" do
        visit root_path
        check_stamp_card_status(ward: "中央区", count_text: "0 / 1")

        visit facility_path(fails_to_check_in_facility)
        expect(page).to have_selector('h1', text: 'チェックインに失敗する施設')

        fill_in_location_and_submit(lat: 35.6751907, lng: 139.7542611) # 約500m北西

        expect(page).to have_selector('#checkin-out-of-range-modal-frame', visible: true, wait: 5)

        within "#checkin-out-of-range-modal-frame" do
          expect(page).to have_content("チェックインに失敗しました😢")
        end

        visit root_path
        check_stamp_card_status(ward: "中央区", count_text: "0 / 1")
      end
    end

    context "when the user has already checked in today" do
      let!(:bunkyo_ward) { create(:ward, name: "文京区", name_kana: "ぶんきょうく") }
      let!(:checked_in_facility) { create(:facility, name: "本日既にチェックインしている施設", latitude: 35.7071868, longitude: 139.7529042, ward: bunkyo_ward) }

      before do
        create(:checkin_log, user: user, facility: checked_in_facility)
      end

      it "fails to check in and the already checked in modal" do
        visit root_path
        check_stamp_card_status(ward: "文京区", count_text: "1 / 1")

        visit facility_path(checked_in_facility)
        expect(page).to have_selector('h1', text: '本日既にチェックインしている施設')

        fill_in_location_and_submit(lat: 35.7078220, lng: 139.7536846) # 約100m北東

        expect(page).to have_selector('#checkin-limit-modal-frame', visible: true, wait: 5)

        within "#checkin-limit-modal-frame" do
          expect(page).to have_content("本日は既にチェックインしています♨️")
          click_button "閉じる"
        end

        click_link "1回訪問"

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"), count: 1)
      end
    end
  end

  describe "check in logs display" do
    context "when there are no check in logs" do
      let!(:chiyoda_ward) { create(:ward, name: "千代田区", name_kana: "ちよだく") }
      let!(:not_check_in_facility) { create(:facility, name: "未チェックイン施設", latitude: 35.698137, longitude: 139.767935, ward: chiyoda_ward) }

      it "displays a message that there are no check in logs yet" do
        visit root_path
        check_stamp_card_status(ward: "千代田区", count_text: "0 / 1")

        visit facility_path(not_check_in_facility)
        expect(page).to have_selector('h1', text: '未チェックイン施設')
        expect(page).to have_content("0回訪問")

        click_link "0回訪問"

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_content("チェックインログはまだありません♨️")
        expect(page).to have_content("施設を訪問してチェックインしましょう！")
      end
    end

    context "when there are more than 11 check in logs" do
      let!(:shinjuku_ward) { create(:ward, name: "新宿区", name_kana: "しんじゅくく") }
      let!(:many_check_in_facility) { create(:facility, name: "ページネーションが表示される施設", ward: shinjuku_ward) }

      before do
        11.times do |i|
          create(:checkin_log, facility: many_check_in_facility, user: user, created_at: i.days.ago)
        end
      end

      it "displays pagination" do
        visit root_path
        check_stamp_card_status(ward: "新宿区", count_text: "1 / 1")

        visit facility_path(many_check_in_facility)
        expect(page).to have_selector('h1', text: 'ページネーションが表示される施設')
        expect(page).to have_content("11回訪問")

        click_link "11回訪問"

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_selector('nav.pagy.nav')
      end
    end
  end
end
