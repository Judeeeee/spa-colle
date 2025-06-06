
module CheckinLogs
  def fill_in_location_and_submit(lat:, lng:)
    page.execute_script("document.getElementById('latitude').value = #{lat};")
    page.execute_script("document.getElementById('longitude').value = #{lng};")

    click_button "チェックイン"
  end

  def check_stamp_card_status(ward:, count_text:)
    expect(page).to have_selector("span", text: ward, wait: 5)

    within(".ward-cell", text: ward, wait: 5) do
      expect(page).to have_text(count_text)
    end
  end
end
