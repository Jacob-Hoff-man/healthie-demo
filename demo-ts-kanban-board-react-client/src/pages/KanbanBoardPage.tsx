import KanbanBoard from '../components/KanbanBoard';
import KanbanProvider from '../contexts/kanban/provider';

const KanbanBoardPage = () => {
    return (
        <KanbanProvider>
            <KanbanBoard />
        </KanbanProvider>
    );
}

export default KanbanBoardPage