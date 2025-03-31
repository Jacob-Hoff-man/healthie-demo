import { CSSProperties } from 'react';
import { DragDropProvider } from '@dnd-kit/react';
import { move } from '@dnd-kit/helpers';
import KanbanBoardColumn from './KanbanBoardColumn';
import KanbanBoardCard from './KanbanBoardCard';
import { useKanbanActionsContext, useKanbanContext } from '../contexts/kanban/context';
import { Flex, Space } from 'antd';

const KanbanBoard = () => {
    const { items } = useKanbanContext();
    const { setItems } = useKanbanActionsContext()

    const styles: CSSProperties = {
        padding: '24px',
        display: 'flex',
        gap: '24px',
    };

    return (
        <DragDropProvider
            onDragOver={(event) => {
                const { source } = event.operation;

                if (!source || source.type === 'column') return;

                setItems(move(items, event));
            }}
        >
            <Flex style={styles}>
                {Object.entries(items).map(([column, columnItems], index) => (
                    <KanbanBoardColumn
                        key={column}
                        id={column}
                        index={index}
                    >
                        {columnItems.map((id, index) => (
                            <KanbanBoardCard
                                key={id}
                                id={id}
                                index={index}
                                column={column}
                            />
                        ))}
                    </KanbanBoardColumn>
                ))}
            </Flex>
        </DragDropProvider>
    );
};

export default KanbanBoard;