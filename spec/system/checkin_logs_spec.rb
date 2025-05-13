require 'rails_helper'

RSpec.describe "CheckinLogs", type: :system do
  let!(:user) { create(:user) }
  let!(:many_check_in_facility) { create(:many_check_in_facility) }
  let!(:checked_in_facility) { create(:checked_in_facility) }
  let!(:previous_day_checked_in_facility) { create(:previous_day_checked_in_facility) }

  before do
    11.times.map { |i| create(:checkin_log, user: user, facility: many_check_in_facility, days_ago: i) }
    create(:checkin_log, user: user, facility: checked_in_facility)
    create(:checkin_log, user: user, facility: previous_day_checked_in_facility, days_ago: 1)
  end

  before(:each) do
    driven_by :selenium_chrome_headless
    login_with_google(user)
  end

  describe "check in functionality" do
    context "when the user checks in for the first time within 200 meters of the facility" do
      let!(:not_check_in_facility) { create(:not_check_in_facility) }

      it "successfully check in and displays first-time check-in modal" do
        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "千代田区", wait: 5)
        within(".ward-cell", text: "千代田区") do
          expect(page).to have_text("0 / 1")
        end

        visit facility_path(not_check_in_facility)
        expect(page).to have_selector('h1', text: '未チェックイン施設')

        fill_in_location_and_submit(lat: 35.698800, lng: 139.768500) # 約100m北東

        expect(page).to have_selector('#checkin-modal-frame', visible: true, wait: 5)

        within "#checkin-modal-frame" do
          expect(page).to have_content("初回チェックイン🎉")
          click_button "閉じる"
        end

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"))

        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "千代田区", wait: 5)
        within(".ward-cell", text: "千代田区") do
          expect(page).to have_text("1 / 1")
        end
      end
    end

    context "when the user has already checked in on a previous day" do
      let!(:previous_day_checked_in_facility) { create(:previous_day_checked_in_facility) }

      it "successfully check in and redirects to the check in log page" do
        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "台東区", wait: 5)
        within(".ward-cell", text: "台東区") do
          expect(page).to have_text("1 / 1")
        end

        visit facility_path(previous_day_checked_in_facility)
        expect(page).to have_selector('h1', text: '昨日チェックインしている施設')

        fill_in_location_and_submit(lat: 35.7138849, lng: 139.7937973) # 約100m北東

        expect(page).to have_selector('h1', text: 'チェックインログ')
        expect(page).to have_content(Time.zone.yesterday.strftime("%Y/%m/%d"), count: 1)
        expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"), count: 1)
      end
    end

    context "when the user is more than 200 meters away from the facility" do
      let!(:fails_to_check_in_facility) { create(:fails_to_check_in_facility) }

      it "fails to check in and displays limit modal" do
        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "中央区", wait: 5)
        within(".ward-cell", text: "中央区") do
          expect(page).to have_text("0 / 1")
        end

        visit facility_path(fails_to_check_in_facility)
        expect(page).to have_selector('h1', text: 'チェックインに失敗する施設')

        fill_in_location_and_submit(lat: 35.6751907, lng: 139.7542611) # 約500m北西

        expect(page).to have_selector('#checkin-out-of-range-modal-frame', visible: true, wait: 5)

        within "#checkin-out-of-range-modal-frame" do
          expect(page).to have_content("チェックインに失敗しました😢")
        end

        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "中央区", wait: 5)
        within(".ward-cell", text: "中央区") do
          expect(page).to have_text("0 / 1")
        end
      end
    end

    context "when the user has already checked in today" do
      let!(:checked_in_facility) { create(:checked_in_facility) }

      it "fails to check in and the already checked in modal" do
        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "文京区", wait: 5)
        within(".ward-cell", text: "文京区") do
          expect(page).to have_text("1 / 1")
        end

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
      let!(:not_check_in_facility) { create(:not_check_in_facility) }

      it "displays a message that there are no check in logs yet" do
        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "千代田区", wait: 5)
        within(".ward-cell", text: "千代田区") do
          expect(page).to have_text("0 / 1")
        end

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
      let!(:many_check_in_facility) { create(:many_check_in_facility) }

      it "displays pagination" do
        visit root_path
        expect(page).to have_selector('h1', text: 'スタンプカード')

        expect(page).to have_selector("span", text: "新宿区", wait: 5)
        within(".ward-cell", text: "新宿区") do
          expect(page).to have_text("1 / 1")
        end

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
