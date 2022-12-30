import L from "leaflet";

class StationMap {

  constructor(element, center, markerClickedCallback) {
    this.map = L.map(element).setView(center, 6);

    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>',
      subdomains: 'abcd',
      maxZoom: 20
    }).addTo(this.map);

    this.markerClickedCallback = markerClickedCallback;
  }

  addMarker(station) {
    const marker =
      L.marker([station.lat, station.lng], { stationId: station.id })
        .addTo(this.map)
        .bindPopup(station.station_number)

    marker.on("click", e => {
      marker.openPopup();
      this.markerClickedCallback(e);
    });

    return marker;
  }

}

export default StationMap;