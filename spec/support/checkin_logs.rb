
module CheckinLogs
  def fill_in_location_and_submit(lat:, lng:)
    page.execute_script("document.getElementById('latitude').value = #{lat};")
    page.execute_script("document.getElementById('longitude').value = #{lng};")

    sleep 5
    click_button "チェックイン"
  end
end
