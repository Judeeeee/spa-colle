
module CheckinLogs
  def fill_in_location(lat:, lng:)
    page.execute_script("document.getElementById('latitude').value = #{lat};")
    page.execute_script("document.getElementById('longitude').value = #{lng};")
  end
end
