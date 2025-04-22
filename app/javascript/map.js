const GeolocationErrorCodes = {
  PERMISSION_DENIED: 1,
};

// Google Maps APIは複数回読み込むとエラーになるので、動的に1回だけ読み込む
function loadGoogleMapsApi(callback) {
  if (typeof google !== "undefined" && google.maps) {
    callback();
    return;
  }

  const existingScript = document.querySelector(
    "script[src*='maps.googleapis.com']",
  );

  if (existingScript) {
    existingScript.addEventListener("load", () => callback());
    return;
  }

  const apiKey = document.querySelector(
    "meta[name='google-maps-api-key']",
  )?.content;

  const script = document.createElement("script");
  script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}`;
  script.async = true;
  script.defer = true;
  script.onload = () => callback();
  document.head.appendChild(script);
}

function initMapWithCurrentLocation() {
  if (!navigator.geolocation) {
    alert("このブラウザは位置情報に対応していません。");
    return;
  }

  navigator.geolocation.getCurrentPosition(
    (position) => {
      const currentLocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };
      initMap(currentLocation);
    },
    (error) => {
      switch (error.code) {
        case GeolocationErrorCodes.PERMISSION_DENIED:
          alert(
            "位置情報の使用が許可されなかったため、現在地を取得できませんでした。",
          );
          break;
        default:
          alert("現在地を取得できませんでした。");
          break;
      }
    },
  );
}

function initMap(center) {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  const facilities = JSON.parse(mapElement.dataset.facilities);

  const map = new google.maps.Map(mapElement, {
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

  facilities.forEach((facility) => {
    const marker = new google.maps.Marker({
      position: { lat: facility.latitude, lng: facility.longitude },
      map: map,
      title: facility.name,
      icon: {
        url: mapElement.dataset.imageUrl,
        scaledSize: new google.maps.Size(38, 31),
      },
    });

    const contentString = `
      <div class="infowindow">
        <h1>${facility.name}</h1>
        <a href='/facilities/${facility.id}'>施設詳細ページへ</a>
      </div>
    `;

    const infowindow = new google.maps.InfoWindow({
      content: contentString,
    });

    marker.addListener("click", () => {
      infowindow.open({ anchor: marker, map });
    });
  });
}

function initMapFacility() {
  const mapElement = document.getElementById("facility-map");
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
              "位置情報の使用が許可されなかったため、現在地を取得できませんでした。",
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

document.addEventListener("turbo:load", () => {
  loadGoogleMapsApi(() => {
    if (document.getElementById("facility-map")) {
      getCurrentLocationAndSetForm();
      initMapFacility();
    } else if (document.getElementById("map")) {
      initMapWithCurrentLocation();
    }
  });
});
