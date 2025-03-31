import { Items } from "../../types/item"

export type KanbanState = {
    items: Items
}

export enum ACTION {
    SET_ITEMS,
}

export type SetItemsAction = {
    type: ACTION.SET_ITEMS
    payload: {
        items: Items
    }
}

export type KanbanAction = SetItemsAction

export type KanbanActions = {
    setItems: (items: Items) => void
}
