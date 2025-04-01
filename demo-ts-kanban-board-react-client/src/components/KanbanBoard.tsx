import { CSSProperties } from 'react';
import { DragDropProvider } from '@dnd-kit/react';
import { move } from '@dnd-kit/helpers';
import KanbanBoardColumn from './KanbanBoardColumn';
import KanbanBoardCard from './KanbanBoardCard';
import { useKanbanActionsContext, useKanbanContext } from '../contexts/kanban/context';
import { Flex } from 'antd';
import ItemProvider from '../contexts/item/provider';
import { ScheduleOutlined } from '@ant-design/icons';
import { useReward } from 'react-rewards';

const KanbanBoard = () => {
    const { items } = useKanbanContext();
    const { setItems } = useKanbanActionsContext()

    const { reward } = useReward(
        'confettiReward',
        'confetti',
        { elementCount: 750, spread: 360, elementSize: 16, startVelocity: 25 });

    const kanbanBoardstyles: CSSProperties = {
        padding: '24px',
        width: '100%',
        overflowX: 'auto',
        gap: '24px',
        display: 'flex',
        justifyContent: 'center',
        boxSizing: 'border-box',
        minWidth: 'fit-content',
    };

    const headerStyles: CSSProperties = {
        padding: '1rem',
        textAlign: 'center',
        fontSize: '2rem',
        fontWeight: 'bold',
        width: '100%',
        boxSizing: 'border-box',
    };

    return (
        <DragDropProvider
            onDragOver={(event) => {
                const { source } = event.operation;

                if (!source || source.type === 'column') return;

                setItems(move(items, event));
            }}
            onDragEnd={(event) => {
                const { target } = event.operation;

                if (!target || target.type === 'column') return;

                if (items['Done'].includes(target.id.toString())) {
                    reward()
                }
            }}
        >
            <div style={headerStyles}>
                <ScheduleOutlined /> Kanban Board
            </div>
            <Flex style={kanbanBoardstyles}>
                {Object.entries(items).map(([column, columnItems], index) => (
                    <ItemProvider key={column}>
                        <KanbanBoardColumn
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
                    </ItemProvider>
                ))}
            </Flex>
        </DragDropProvider>
    );
};

export default KanbanBoard;