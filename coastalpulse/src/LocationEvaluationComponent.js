import React, { useState, useEffect, useRef  } from 'react';
import axios from 'axios';


const LocationEvaluationComponent = ({ location }) => {
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [answer, setAnswer] = useState(null);
    const [axiosSend, setAxiosSend] = useState(false);
    const apiKey = 'MYTOKEN';
    const headers = {
      'Content-Type':'application/json',
      'Authorization': `Bearer ${apiKey}`,
    };
    const question = `Tell me about ${location.split(',')[0]}`;
  
    const handleSubmit = async () => {
      try {
        const response = await axios.get('http://127.0.0.1:8000/openai', {
          headers,
          params: {
            question,
          },
        });
        setAnswer(response.data.answer);
        setAxiosSend(true);
      } catch (error) {
        console.error(error);
        setAxiosSend(true);
    } finally {
        setAxiosSend(true);
      }
    };
  
    useEffect(() => {
      handleSubmit();
    }, []);
  
    return (
      <div className='locationEvaluation'>
        {axiosSend ? (
          <div>
            <h3>Κρήτη</h3>
            <div class='row'>
            <h2>Υπολογισμός ΡΟΙ %</h2>
              <div class='col-6'>
                <h5>Μέσος Όρος Επισκεπτών</h5>
                <p>43.7</p>
              </div>
              <div class='col-6'>
                <h5>Μέσος Όρος Δαπανών</h5>
                <p>322</p>
              </div>
            </div>
            <div class='row'>
              <h5>Χώρα Προέλευσης Ταξιδιωτών</h5>
              
              <ul style={{ listStyle: 'none' }}>
                <li style={{ backgroundImage: 'url(https://www.freepnglogos.com/pics/american-usa-flag)' }}>USA</li>
                <li style={{ backgroundImage: 'url(/germany-flag.png)' }}>Germany</li>
                <li style={{ backgroundImage: 'url(/spain-flag.png)' }}>Spain</li>
                <li style={{ backgroundImage: 'url(/france-flag.png)' }}>France</li>
                <li style={{ backgroundImage: 'url(/russia-flag.png)' }}>Russia</li>
            </ul>

              
            </div>
            <div class='row'>
            <div class='col-6'>
            <h5>Αριθμός Επισκεπτών</h5>
            <img src='public/1.png'/>
            </div>
            <div class='col-6'>
            <h5>Δαπάνες Επισκεπτών</h5>
            <img src='public/1.png'/>
            </div>
            <div class='col-6'>
            <h5>Μέσος Όρος Διάρκειας Επίσκεψης</h5>
            <img src='public/1.png'/>
            </div>
            <div class='col-6'>
            <h5>Δαπάνες ανά Διανυκτέρευση</h5>
            <img src='public/1.png'/>
            </div>
            </div>
          </div>
        ) : (
          <p>Select a location for evaluation...</p>
        )}
      </div>
    );
  };
  
  export default LocationEvaluationComponent;
  