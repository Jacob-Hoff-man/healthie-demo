import { useSortable } from "@dnd-kit/react/sortable";
import { Card, Typography } from "antd";
import { DeleteOutlined } from "@ant-design/icons";
import { CSSProperties, useState } from "react";
import { useKanbanActionsContext } from "../contexts/kanban/context";

const { Title } = Typography;

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

    const { removeItem } = useKanbanActionsContext();

    const { ref, isDragging } = useSortable({
        id,
        index,
        type: 'item',
        accept: 'item',
        group: column
    });

    const style: CSSProperties = {
        cursor: 'grab',
        opacity: isDragging ? 0.5 : 1,
        touchAction: 'none',
        marginBottom: '8px',
        transition: 'transform 2s ease',
        position: 'relative',
    };

    const deleteIconStyle: CSSProperties = {
        position: 'absolute',
        top: '16px',
        right: '16px',
        cursor: 'pointer',
        opacity: isHovered ? 1 : 0,
        transition: 'opacity 0.5s ease',
        color: '#ff4d4f',
    };

    const handleDelete = () => {
        removeItem(column, id);
    };

    return (
        <Card
            ref={ref}
            style={style}
            data-dragging={isDragging}
            onMouseEnter={() => setIsHovered(true)}
            onMouseLeave={() => setIsHovered(false)}
        >
            <DeleteOutlined
                style={deleteIconStyle}
                onClick={handleDelete}
                disabled={!isHovered}
            />
            <Title level={5}>{id}</Title>
        </Card>
    );
};

export default KanbanBoardCard;