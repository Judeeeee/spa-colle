const GeolocationErrorCodes = {
  PERMISSION_DENIED: 1,
};

function initMap() {
  const mapElement = document.getElementById("map");
  const latitude = parseFloat(mapElement.dataset.latitude);
  const longitude = parseFloat(mapElement.dataset.longitude);
  const imageUrl = mapElement.dataset.imageUrl;
  const googleMapUrl = `https://www.google.com/maps?q=${latitude},${longitude}`;

  let map = new google.maps.Map(mapElement, {
    center: { lat: latitude, lng: longitude },
    zoom: 18,
  });

  const contentString = `
     <div class="infowindow">
       <a href="${googleMapUrl}" target="_blank">Googleマップへ移動</a>
     </div>
   `;

  const infowindow = new google.maps.InfoWindow({
    content: contentString,
  });

  const marker = new google.maps.Marker({
    position: { lat: latitude, lng: longitude },
    map: map,
    icon: {
      url: imageUrl,
      scaledSize: new google.maps.Size(38, 31),
    },
  });

  marker.addListener("click", function () {
    infowindow.open(map, marker);
  });
}

function getCurrentLocationAndSetForm() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function (position) {
        document.getElementById("latitude").value = position.coords.latitude;
        document.getElementById("longitude").value = position.coords.longitude;
      },
      function (error) {
        switch (error.code) {
          case GeolocationErrorCodes.PERMISSION_DENIED:
            alert(
              "位置情報の使用が許可されなかっため、現在地を取得できませんでした。",
            );
            break;
          default:
            alert("現在地を取得できませんでした");
            break;
        }
      },
    );
  } else {
    alert("このブラウザは位置情報に対応していません。");
  }
}

function initPage() {
  getCurrentLocationAndSetForm();
  initMap();
}

document.addEventListener("DOMContentLoaded", initPage);
