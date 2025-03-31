import { Routes, Route } from 'react-router-dom';
import { ScheduleOutlined } from '@ant-design/icons'
import KanbanBoardPage from './pages/KanbanBoardPage';
import { CSSProperties } from 'react';

function App() {
  const appStyles: CSSProperties = {
    display: 'flex',
    flexDirection: 'column',
    height: '100%',
    overflow: 'hidden',
  };

  const headerStyles: CSSProperties = {
    padding: '1rem',
    flexShrink: 0,
  };

  return (
    <div style={appStyles}>
      <div style={headerStyles}>
        <ScheduleOutlined /> Kanban board
      </div>
      <Routes>
        <Route path="/" element={<KanbanBoardPage />} />
      </Routes>
    </div>
  );
}

export default App;