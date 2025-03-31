import { Button, Card, Flex, Input, Space, Typography } from 'antd';
import { CSSProperties, useMemo } from 'react';
import { Item } from '../types/item';
import { useItemActionsContext, useItemContext } from '../contexts/item/context';
import { useKanbanContext } from '../contexts/kanban/context';

const { Text } = Typography;

type KanbanBoardAddCardProps = {
    onConfirm: (item: Item) => void;
    onCancel: () => void;
};

const KanbanBoardAddCard = ({ onConfirm, onCancel }: KanbanBoardAddCardProps) => {
    const { items } = useKanbanContext();

    const { item } = useItemContext();
    const { setItemTitle, setItemDescription } = useItemActionsContext();

    const cardStyles: CSSProperties = {
        width: '100%',
        backgroundColor: '#ffffff',
    };

    const spaceStyles: CSSProperties = {
        width: '100%',
    };

    const invalidTitleStyles: CSSProperties = {
        fontSize: '12px',
        height: '22px',
        marginBottom: '4px'
    };

    const isTitleUnique = useMemo(() =>
        !Object.values(items).flat().includes(item.title),
        [items, item]);

    const isDisabled = useMemo(() => {
        const isTitleEmpty = item.title.trim() === '';
        const isDescriptionEmpty = item.description.trim() === '';

        return !isTitleUnique || isTitleEmpty || isDescriptionEmpty;
    }, [items, item, isTitleUnique]);

    const handleConfirm = () => {
        if (!isDisabled) {
            onConfirm(item);
        }
    };

    return (
        <Card style={cardStyles}>
            <Space direction="vertical" style={spaceStyles}>
                <div style={invalidTitleStyles}>
                    {item.title.trim() && !isTitleUnique ? (
                        <Text type="danger">Title must be unique</Text>
                    ) : (<Text>Add a new card</Text>)}
                </div>
                <Input
                    placeholder="Enter Title"
                    value={item.title}
                    onChange={(e) => setItemTitle(e.target.value)}
                    onPressEnter={handleConfirm}
                    status={item.title.trim() && !isTitleUnique ? 'error' : undefined}
                    title={!isTitleUnique ? 'Title must be unique' : undefined}
                />
                <Input
                    placeholder="Enter Description"
                    value={item.description}
                    onChange={(e) => setItemDescription(e.target.value)}
                    onPressEnter={handleConfirm}
                />
                <Flex gap="small" justify="flex-end">
                    <Button onClick={onCancel}>Cancel</Button>
                    <Button type="primary" onClick={handleConfirm} disabled={isDisabled}>
                        Add
                    </Button>
                </Flex>
            </Space>
        </Card>
    );
};

export default KanbanBoardAddCard; 