class GoogleMap {
  static async init() {
    await this.loadGoogleMapsApi();

    if (document.getElementById("facility-map")) {
      await this.setCurrentLocationToForm();
      this.initMapFacility();
    } else if (document.getElementById("map")) {
      await this.initMapWithCurrentLocation();
    }
  }

  static async loadGoogleMapsApi() {
    if (typeof google !== "undefined" && google.maps) return;

    const existingScript = document.querySelector(
      "script[src*='maps.googleapis.com']",
    );
    if (existingScript) {
      return new Promise((resolve) =>
        existingScript.addEventListener("load", resolve),
      );
    }

    const apiKey = document.querySelector(
      "meta[name='google-maps-api-key']",
    )?.content;
    return new Promise((resolve) => {
      const script = document.createElement("script");
      script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}`;
      script.async = true;
      script.defer = true;
      script.onload = resolve;
      document.head.appendChild(script);
    });
  }

  static async getCurrentLocation() {
    if (!navigator.geolocation) throw new Error("Geolocation is not supported");

    return new Promise((resolve, reject) => {
      navigator.geolocation.getCurrentPosition(resolve, reject);
    });
  }

  static alertGeolocationError(error) {
    if (error.code === 1) {
      alert(
        "位置情報の使用が許可されなかったため、現在地を取得できませんでした。",
      );
    } else {
      alert("現在地を取得できませんでした");
    }
  }

  static async setCurrentLocationToForm() {
    try {
      const position = await this.getCurrentLocation();
      document.getElementById("latitude").value = position.coords.latitude;
      document.getElementById("longitude").value = position.coords.longitude;
    } catch (error) {
      this.alertGeolocationError(error);
    }
  }

  static initMapFacility() {
    const mapElement = document.getElementById("facility-map");
    if (!mapElement) return;

    const latitude = parseFloat(mapElement.dataset.latitude);
    const longitude = parseFloat(mapElement.dataset.longitude);
    const imageUrl = mapElement.dataset.imageUrl;
    const googleMapUrl = `https://www.google.com/maps?q=${latitude},${longitude}`;
    const map = new google.maps.Map(mapElement, {
      center: { lat: latitude, lng: longitude },
      zoom: 18,
    });

    this.createMarkerWithInfoWindow(map, {
      position: { lat: latitude, lng: longitude },
      iconUrl: imageUrl,
      infoContent: `<div class="infowindow"><a href="${googleMapUrl}" target="_blank">Googleマップへ移動</a></div>`,
    });
  }

  static async initMapWithCurrentLocation() {
    try {
      const position = await this.getCurrentLocation();
      const currentLocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };
      this.displayCurrentLocation(currentLocation);
    } catch (error) {
      this.alertGeolocationError(error);
    }
  }

  static displayCurrentLocation(center) {
    const mapElement = document.getElementById("map");
    if (!mapElement) return;

    const facilities = JSON.parse(mapElement.dataset.facilities);
    const map = new google.maps.Map(mapElement, {
      center: center,
      zoom: 12,
    });

    // 現在地マーカー
    new google.maps.Marker({
      position: center,
      map: map,
      title: "現在地",
      icon: {
        url: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png",
        scaledSize: new google.maps.Size(38, 31),
      },
    });

    // 施設マーカー
    facilities.forEach((facility) => {
      this.createMarkerWithInfoWindow(map, {
        position: { lat: facility.latitude, lng: facility.longitude },
        iconUrl: mapElement.dataset.imageUrl,
        infoContent: `
          <div class="infowindow">
            <h1>${facility.name}</h1>
            <a href='/facilities/${facility.id}'>施設詳細ページへ</a>
          </div>
        `,
        title: facility.name,
      });
    });
  }

  static createMarkerWithInfoWindow(
    map,
    { position, iconUrl, infoContent, title },
  ) {
    const marker = new google.maps.Marker({
      position,
      map,
      title,
      icon: {
        url: iconUrl,
        scaledSize: new google.maps.Size(38, 31),
      },
    });

    const infowindow = new google.maps.InfoWindow({ content: infoContent });

    marker.addListener("click", () => {
      infowindow.open({ anchor: marker, map });
    });
  }
}

document.addEventListener("turbo:load", () => {
  GoogleMap.init();
});
