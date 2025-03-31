import { Flex, Space, Typography } from "antd";
import { useSortable } from "@dnd-kit/react/sortable";
import { CollisionPriority } from "@dnd-kit/abstract";
import { CSSProperties, ReactNode } from "react";

const { Title } = Typography;

type KanbanBoardColumnProps = {
    id: string;
    children: ReactNode;
    index: number;
}

const KanbanBoardColumn = ({ id, children, index }: KanbanBoardColumnProps) => {
    const { ref } = useSortable({
        id,
        index,
        type: 'column',
        collisionPriority: CollisionPriority.Low,
        accept: ['item', 'column'],
    });

    const style: CSSProperties = {
        padding: '16px',
        borderRadius: '8px',
        width: '300px',
        maxHeight: '80vh',
        display: 'flex',
        flexDirection: 'column',
        gap: '16px',
        backgroundColor: '#d0d0d0',
        boxShadow: '0 2px 8px rgba(0, 0, 0, 0.15)'
    };

    const titleStyle: CSSProperties = {
        textAlign: 'center',
        margin: 0
    };

    const cardsStyle: CSSProperties = {
        display: 'flex',
        flexDirection: 'column',
        gap: '16px',
        overflowY: 'auto'
    };

    return (
        <Flex ref={ref} style={style}>
            <Title level={3} style={titleStyle}>{id}</Title>
            <Flex style={cardsStyle}>
                {children}
            </Flex>
        </Flex>
    );
};

export default KanbanBoardColumn;