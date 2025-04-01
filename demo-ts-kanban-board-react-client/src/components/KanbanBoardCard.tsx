import { useSortable } from "@dnd-kit/react/sortable";
import { Card, Typography } from "antd";
import { DeleteColumnOutlined, DeleteOutlined, DeleteTwoTone } from "@ant-design/icons";
import { CSSProperties, useState } from "react";
import { useKanbanActionsContext, useKanbanContext } from "../contexts/kanban/context";

const { Title, Text } = Typography;

type KanbanBoardCardProps = {
    id: string;
    index: number;
    column: string;
}

const KanbanBoardCard = ({
    id,
    index,
    column
}: KanbanBoardCardProps) => {
    const [isHovered, setIsHovered] = useState(false);

    const { cards } = useKanbanContext();

    const { removeItem } = useKanbanActionsContext();

    const { ref, isDragging } = useSortable({
        id,
        index,
        type: 'item',
        accept: 'item',
        group: column
    });

    const handleDelete = () => {
        removeItem(column, id);
    };

    const cardStyles: CSSProperties = {
        cursor: 'grab',
        opacity: isDragging ? 0.5 : 1,
        touchAction: 'none',
        marginBottom: '8px',
        transition: 'transform 2s ease',
        position: 'relative',
    };

    const deleteIconStyles: CSSProperties = {
        position: 'absolute',
        top: '16px',
        right: '16px',
        cursor: 'pointer',
        opacity: isHovered ? 1 : 0,
        transition: 'opacity 0.5s ease',
        color: '#ff4d4f',
    };

    return (
        <Card
            ref={ref}
            style={cardStyles}
            data-dragging={isDragging}
            onMouseEnter={() => setIsHovered(true)}
            onMouseLeave={() => setIsHovered(false)}
        >
            <DeleteOutlined
                style={deleteIconStyles}
                onClick={handleDelete}
                disabled={!isHovered}
            />
            <Title level={5}>{cards[id].title}</Title>
            <Text>{cards[id].description}</Text>
        </Card>
    );
};

export default KanbanBoardCard;