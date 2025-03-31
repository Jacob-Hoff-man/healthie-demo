import { createRoot } from 'react-dom/client'
import App from './App.tsx'
import { BrowserRouter } from 'react-router-dom';

// global styles
const styleSheet = document.createElement("style");
styleSheet.textContent = `
  html {
    font-family: sans-serif;
    font-size: 16px;
  }

  html,
  body {
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
    background-color: rgb(246, 248, 250);
  }

  #root {
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  height: 100%;
  width: 100%;
  margin: 0;
  padding: 0;
}
`;
document.head.appendChild(styleSheet);

createRoot(document.getElementById('root')!).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
);