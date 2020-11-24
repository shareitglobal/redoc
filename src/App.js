import React from 'react';
import './App.css';

import { RedocStandalone } from 'redoc';

function App() {
  return (
    <RedocStandalone
      specUrl={process.env.PUBLIC_URL + "/shareit-vehiclelist-v1-openapi.yaml"}
    />
  )
}

export default App;
