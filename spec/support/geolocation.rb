
module Geolocation
  def mock_geolocation_success(latitude, longitude)
    page.execute_script(<<~JS)
      Object.defineProperty(navigator, "geolocation", {
        value: {
          getCurrentPosition: function(success, error) {
            success({ coords: { latitude: #{latitude}, longitude: #{longitude} } });
          }
        }
      });
    JS
  end

  def mock_geolocation_error
    page.execute_script(<<~JS)
      Object.defineProperty(navigator, "geolocation", {
        value: {
          getCurrentPosition: function(success, error) {
            error({ code: 1, message: "User denied Geolocation" });
          }
        }
      });
    JS
  end
end
