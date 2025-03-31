import { Routes, Route } from 'react-router-dom';
import { ScheduleOutlined } from '@ant-design/icons'
import KanbanBoardPage from './pages/KanbanBoardPage';
import { CSSProperties } from 'react';
import { Space } from 'antd';

function App() {
  const appStyles: CSSProperties = {
    display: 'flex',
    flexDirection: 'column',
    height: '100%',
    overflow: 'hidden',
  };

  return (
    <div style={appStyles}>
      <Routes>
        <Route path="/" element={<KanbanBoardPage />} />
      </Routes>
    </div>
  );
}

export default App;