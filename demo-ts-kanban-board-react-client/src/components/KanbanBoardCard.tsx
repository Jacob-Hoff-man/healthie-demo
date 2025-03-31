import { useSortable } from "@dnd-kit/react/sortable";
import { Card, Typography } from "antd";
import { CSSProperties } from "react";

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
    };

    return (
        <Card
            ref={ref}
            style={style}
            data-dragging={isDragging}
        >
            <Title level={5}>{id}</Title>
        </Card>
    );
};

export default KanbanBoardCard;