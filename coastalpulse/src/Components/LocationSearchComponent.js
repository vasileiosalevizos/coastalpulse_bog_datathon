import React, { useState, useEffect, useRef  } from 'react';
import axios from 'axios';


const LocationSearchComponent = ({ onLocationSelect }) => {
  const [searchText, setSearchText] = useState('');
  const [suggestions, setSuggestions] = useState([]);
  const timerRef = useRef(null);

  useEffect(() => {
    if (searchText.length < 3) {
      setSuggestions([]);
      return;
    }

    if (timerRef.current) {
        clearTimeout(timerRef.current);
      }

    timerRef.current = setTimeout(async () => {
      const response = await axios.get('https://nominatim.openstreetmap.org/search', {
        params: {
          q: searchText,
          format: 'json',
          addressdetails: 1,
          limit: 5,
        },
      }).catch((error) => {
        console.error('There was a problem with the axios request:', error);
      });

      setSuggestions(response.data);
    }, 1500);

    return () => {
        clearTimeout(timerRef.current);
      };
    }, [searchText]);


  const handleSuggestionClick = (location) => {
    setSearchText(location.display_name);
    setSuggestions([]);
    onLocationSelect(location);
  };

  return (
    <div className='location-search' class='container-md'>
        <input class='form-control' type='text' value={searchText} onChange={(e) => setSearchText(e.target.value)} 
        placeholder='Enter a location' />
        {suggestions.length > 0 && (
            <ul className='suggestions'>
                {suggestions.map((suggestion) => (
                    <li key={suggestion.place_id} onClick={() => handleSuggestionClick(suggestion)}>
                        {suggestion.display_name}
                    </li>
                ))}
            </ul>
        )}
    </div>
  );
};

export default LocationSearchComponent;