
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

// Mapbox Theme
const buildMap = (mapElement) => {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    return new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/dark-v10'
    });
};
// Add markers to the map
const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this
        new mapboxgl.Marker()
            .setLngLat([marker.lng, marker.lat])
            .setPopup(popup) // add this
            .addTo(map);
    });
};

// fit the markers on rendered map
const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    console.log(markers)
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { duration: 1500, padding: 70, maxZoom: 15 });
};

// main function
const initMapbox = () => {

    const mapElement = document.getElementById('map');
    if (mapElement) {
        const map = buildMap(mapElement);
        const markers = JSON.parse(mapElement.dataset.markers);
        addMarkersToMap(map, markers);
        fitMapToMarkers(map, markers);

        // For Search function on your map
        // map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
        // mapboxgl: mapboxgl }));
    }
};

export { initMapbox, fitMapToMarkers };
// export { fitMapToMarkers };
