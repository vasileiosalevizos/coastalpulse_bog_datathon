import React, { useState, useEffect, useRef  } from 'react';
import axios from 'axios';


const LocationEvaluationComponent = ({ location }) => {
  const [isSubmitting, setIsSubmitting] = useState(false);
    var question = 'Tell me about ' + location;
    var answer;
  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    try {
      const response = await axios.get('http://127.0.0.1:8000/openai', { question });
      console.log(response.data);
      answer = response.data;
    } catch (error) {
      console.error(error);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className='locationEvaluation'>
        <p>{answer}</p>
    </div>
  );
};

export default LocationEvaluationComponent;
