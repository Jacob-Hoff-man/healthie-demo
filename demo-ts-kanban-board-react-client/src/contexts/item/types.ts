import { Item } from "../../types/item"

export type ItemState = {
    item: Item
    isAddingItem: boolean
}

export enum ACTION {
    // item management
    SET_IS_ADDING_ITEM,
    SET_ITEM_TITLE,
    SET_ITEM_DESCRIPTION,
    CLEAR_ITEM,
}

export type SetIsAddingItemAction = {
    type: ACTION.SET_IS_ADDING_ITEM
    payload: {
        isAddingItem: boolean
    }
}

export type ClearItemAction = {
    type: ACTION.CLEAR_ITEM
}

export type SetItemTitleAction = {
    type: ACTION.SET_ITEM_TITLE
    payload: {
        title: string
    }
}

export type SetItemDescriptionAction = {
    type: ACTION.SET_ITEM_DESCRIPTION
    payload: {
        description: string
    }
}

export type ItemAction =
    | ClearItemAction
    | SetItemTitleAction
    | SetItemDescriptionAction
    | SetIsAddingItemAction

export type ItemActions = {
    setIsAddingItem: (isAddingItem: boolean) => void
    clearItem: () => void
    setItemTitle: (title: string) => void
    setItemDescription: (description: string) => void
}
