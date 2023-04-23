import React, { useRef, useEffect } from 'react';
import L from 'leaflet';

const MapComponent = ({ center }) => {
  const mapRef = useRef(null);

  useEffect(() => {
    let map;

    if (mapRef.current) {
      map = L.map(mapRef.current).setView(center || [37.972895501551186, 23.725779081429827], 13);

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution:
          '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
        maxZoom: 19,
      }).addTo(map);
    }

    return () => {
      if (map) {
        map.remove();
      }
    };
  }, []);

  useEffect(() => {
    if (mapRef.current && mapRef.current.leafletMap && center) {
      const mapInstance = mapRef.current.leafletMap;
      mapInstance.flyTo(center);
    }
  }, [center]);

  return (
    <div className="Map">
      <div id="map" ref={mapRef} style={{ height: '300px', width: '100%', marginTop:'15px' }}></div>
    </div>
  );
};

export default MapComponent;
