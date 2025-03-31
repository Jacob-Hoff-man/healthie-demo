import { Items } from "../../types/kanban"

export type KanbanState = {
    items: Items
}

export enum ACTION {
    // items map management
    SET_ITEMS,
    ADD_ITEM,
    REMOVE_ITEM,
}

export type AddItemAction = {
    type: ACTION.ADD_ITEM
    payload: {
        columnId: string
        item: string
    }
}

export type RemoveItemAction = {
    type: ACTION.REMOVE_ITEM
    payload: {
        columnId: string
        item: string
    }
}

export type SetItemsAction = {
    type: ACTION.SET_ITEMS
    payload: {
        items: Items
    }
}

export type KanbanAction =
    | SetItemsAction
    | AddItemAction
    | RemoveItemAction

export type KanbanActions = {
    setItems: (items: Items) => void
    addItem: (columnId: string, item: string) => void
    removeItem: (columnId: string, item: string) => void
}
