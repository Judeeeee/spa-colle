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

document.addEventListener("DOMContentLoaded", function () {
  initMap();
  const checkInBtn = document.getElementById("check-in-btn");

  checkInBtn.addEventListener("click", function (event) {
    event.preventDefault();
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function (position) {
        document.getElementById("latitude").value = position.coords.latitude;
        document.getElementById("longitude").value = position.coords.longitude;
        document.getElementById("check-in-form").submit();
      });
    } else {
      alert("現在地を取得できません。");
    }
  });
});
