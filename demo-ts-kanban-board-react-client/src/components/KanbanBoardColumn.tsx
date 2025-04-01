import { Button, Flex, Typography } from "antd";
import { useSortable } from "@dnd-kit/react/sortable";
import { CollisionPriority } from "@dnd-kit/abstract";
import { CSSProperties, ReactNode } from "react";
import { PlusOutlined } from "@ant-design/icons";
import KanbanBoardAddCard from "./KanbanBoardAddCard";
import { useKanbanActionsContext } from "../contexts/kanban/context";
import { Item } from "../types/item";
import { useItemActionsContext, useItemContext } from "../contexts/item/context";

const { Title } = Typography;

type KanbanBoardColumnProps = {
    id: string;
    children: ReactNode;
    index: number;
}

const KanbanBoardColumn = ({ id, children, index }: KanbanBoardColumnProps) => {
    const { addItem } = useKanbanActionsContext();

    const { isAddingItem } = useItemContext();
    const { setIsAddingItem, clearItem } = useItemActionsContext();

    const { ref, isDragging } = useSortable({
        id,
        index,
        type: 'column',
        collisionPriority: CollisionPriority.Low,
        accept: ['item', 'column'],
    });

    const handleAddCard = (newItem: Item) => {
        addItem(id, newItem)
        setIsAddingItem(false);
        clearItem();
    };

    const handleCancelAddCard = () => {
        setIsAddingItem(false);
        clearItem();
    };

    const columnStyles: CSSProperties = {
        padding: '16px',
        borderRadius: '8px',
        width: '300px',
        height: '80vh',
        display: 'flex',
        flexDirection: 'column',
        gap: '16px',
        backgroundColor: '#d0d0d0',
        boxShadow: '0 2px 8px rgba(0, 0, 0, 0.15)',
        opacity: isDragging ? 0.5 : 1,
        touchAction: 'none',
        transition: 'transform 2s ease',
    };

    const titleStyles: CSSProperties = {
        textAlign: 'center',
        margin: 0,
        flexShrink: 0
    };

    const cardsStyles: CSSProperties = {
        display: 'flex',
        flexDirection: 'column',
        gap: '16px',
        overflowY: 'auto',
        flex: 1,
        minHeight: 0
    };

    const addButtonStyles: CSSProperties = {
        height: '40px'
    };

    return (
        <div ref={ref} style={columnStyles} >
            <Title
                level={3}
                style={titleStyles}
                id={id === 'Done' ? 'confettiReward' : ''}
            >
                {id}
            </Title>
            <div style={cardsStyles}>
                {children}
            </div>
            {isAddingItem ? (
                <KanbanBoardAddCard
                    onConfirm={handleAddCard}
                    onCancel={handleCancelAddCard}
                />
            ) : (
                <Button
                    type="dashed"
                    icon={<PlusOutlined />}
                    onClick={() => setIsAddingItem(true)}
                    style={addButtonStyles}
                >
                    Add Card
                </Button>
            )}
        </div>
    );
};

export default KanbanBoardColumn;