import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

// Create a React "root" attached to the #root div
const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
  // StrictMode adds extra development-only warnings - the output remains the same
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
