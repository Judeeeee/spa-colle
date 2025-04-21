const GeolocationErrorCodes = {
  PERMISSION_DENIED: 1,
};

function initMapWithCurrentLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function (position) {
        const currentLocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
        initMap(currentLocation);
      },
      function (error) {
        switch (error.code) {
          case GeolocationErrorCodes.PERMISSION_DENIED:
            alert(
              "位置情報の使用が許可されなかっため、現在地を取得できませんでした。"
            );
            break;
          default:
            alert("現在地を取得できませんでした");
            break;
        }
      }
    );
  } else {
    alert("このブラウザは位置情報に対応していません。");
  }
}

function initMap(center) {
  const facilities = JSON.parse(
    document.getElementById("map").dataset.facilities
  );

  const map = new google.maps.Map(document.getElementById("map"), {
    center: center,
    zoom: 12,
  });

  new google.maps.Marker({
    position: center,
    map: map,
    title: "現在地",
    icon: {
      url: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png",
      scaledSize: new google.maps.Size(38, 31),
    },
  });

  facilities.forEach(function (facility) {
    const marker = new google.maps.Marker({
      position: { lat: facility.latitude, lng: facility.longitude },
      map: map,
      title: facility.name,
      icon: {
        url: document.getElementById("map").dataset.imageUrl,
        scaledSize: new google.maps.Size(38, 31),
      },
    });
    const contentString = `
      <div class="infowindow">
        <h1>
          ${facility.name}
        </h1>
        <a href='/facilities/${facility.id}'>
          施設詳細ページへ
        </a>
      </div>
    `;
    const infowindow = new google.maps.InfoWindow({
      content: contentString,
    });

    marker.addListener("click", () => {
      infowindow.open({
        anchor: marker,
        map,
      });
    });
  });
}

document.addEventListener("DOMContentLoaded", initMapWithCurrentLocation);
