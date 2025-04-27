require 'rails_helper'

RSpec.describe "CheckinLogs", type: :system do
  let(:user) { create(:user) }
  let!(:not_check_in_facility) { create(:not_check_in_facility) }
  let!(:fails_to_check_in_facility) { create(:fails_to_check_in_facility) }
  let!(:many_check_in_facility) { create(:many_check_in_facility) }
  let!(:checked_in_facility) { create(:checked_in_facility) }
  let!(:previous_day_checked_in_facility) { create(:previous_day_checked_in_facility) }
  let!(:checkin_logs) do
    11.times.map { |i| create(:checkin_log, user: user, facility: many_check_in_facility, days_ago: i) }
  end
  let!(:checked_in_log) { create(:checkin_log, user: user, facility: checked_in_facility) }
  let!(:yesterday_checked_in_log) { create(:checkin_log, user: user, facility: previous_day_checked_in_facility, days_ago: 1) }

  before(:each) do
    driven_by :selenium_chrome_headless
    login_with_google(user)
    expect(page).to have_selector('h1', text: 'スパコレ')
  end

  def fill_in_location_and_submit(lat:, lng:)
    page.execute_script("document.getElementById('latitude').value = #{lat};")
    page.execute_script("document.getElementById('longitude').value = #{lng};")

    click_button "チェックイン"
  end

  context "the current location is within 200 meters of the facility" do
    it "successfully checks in" do
      visit facility_path(not_check_in_facility)
      expect(page).to have_selector('h1', text: '未チェックイン施設')

      fill_in_location_and_submit(lat: 35.698800, lng: 139.768500) # 約100m北東

      within "#checkin-modal-frame" do
        expect(page).to have_content("初回チェックイン🎉")
        click_button "閉じる"
      end

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"))
    end

    it "fails to check in" do
      visit facility_path(fails_to_check_in_facility)
      expect(page).to have_selector('h1', text: 'チェックインに失敗する施設')

      fill_in_location_and_submit(lat: 35.6751907, lng: 139.7542611) # 約500m北西

      within "#checkin-out-of-range-modal-frame" do
        expect(page).to have_content("チェックインに失敗しました😢")
      end
    end
  end

  context "when checking in to a facility already checked in today" do
    it "displays an already checked-in modal" do
      visit facility_path(checked_in_facility)
      expect(page).to have_selector('h1', text: '本日既にチェックインしている施設')

      fill_in_location_and_submit(lat: 35.7078220, lng: 139.7536846) # 約100m北東

      within "#checkin-limit-modal-frame" do
        expect(page).to have_content("本日は既にチェックインしています♨️")
        click_button "閉じる"
      end

      click_link "チェックインログページへ"

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"), count: 1)
    end
  end

  context "When checking in to a facility checked in yesterday" do
    it "Does not display the modal and redirects to the check-in log page" do
      visit facility_path(previous_day_checked_in_facility)
      expect(page).to have_selector('h1', text: '昨日チェックインしている施設')

      fill_in_location_and_submit(lat: 35.7138849, lng: 139.7937973) # 約100m北東

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_content(Time.zone.yesterday.strftime("%Y/%m/%d"), count: 1)
      expect(page).to have_content(Time.zone.today.strftime("%Y/%m/%d"), count: 1)
    end
  end

  context "when there are no check-in logs" do
    it "displays a message indicating that there are no check in logs yet" do
      visit facility_path(not_check_in_facility)
      expect(page).to have_selector('h1', text: '未チェックイン施設')
      expect(page).to have_content("0回訪問")

      click_link "チェックインログページへ"

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_content("チェックインログはまだありません♨️")
      expect(page).to have_content("施設を訪問してチェックインしましょう！")
    end
  end

  context "when there are 11 more check-in logs" do
    it "displays pagination" do
      visit facility_path(many_check_in_facility)
      expect(page).to have_selector('h1', text: 'ページネーションが表示される施設')
      expect(page).to have_content("11回訪問")

      click_link "チェックインログページへ"

      expect(page).to have_selector('h1', text: 'チェックインログ')
      expect(page).to have_selector('nav.pagy.nav')
    end
  end
end
