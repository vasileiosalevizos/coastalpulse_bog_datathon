import React, { useState } from 'react';
import LocationSearchComponent from './Components/LocationSearchComponent';
import MapComponent from './Components/MapComponent';
import Navbar from './Components/NavBar';
import LocationEvaluationComponent from './LocationEvaluationComponent';

const HomePage = () => {
  const [center, setCenter] = useState(null);
  const [loc, setLoc] = useState(null);
  const handleLocationSelect = (location) => {
    setCenter([location.lat, location.lon]);
    setLoc(location)
  };

  return (
    <div>
      <Navbar />
      <h1>Hello User</h1>
      <p>Search a location!</p>
      <div class='container-xl justify-content-center align-items-center' style={{ height: '400px', width: '100%' }}>
        <LocationSearchComponent onLocationSelect={handleLocationSelect} />
        <MapComponent center={center} />
        {center && <LocationEvaluationComponent location={loc.display_name} />}
      </div>
    </div>
  );
};

export default HomePage;
