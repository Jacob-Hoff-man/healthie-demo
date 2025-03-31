import { ACTION, ItemAction, ItemState } from "./types"

export const itemStateReducer = (state: ItemState, action: ItemAction): ItemState => {
    switch (action.type) {
        case ACTION.CLEAR_ITEM: {
            return {
                ...state,
                item: { title: '', description: '' }
            }
        }
        case ACTION.SET_ITEM_TITLE: {
            return {
                ...state,
                item: { ...state.item, title: action.payload.title }
            }
        }
        case ACTION.SET_ITEM_DESCRIPTION: {
            return {
                ...state,
                item: { ...state.item, description: action.payload.description }
            }
        }
        case ACTION.SET_IS_ADDING_ITEM: {
            return {
                ...state,
                isAddingItem: action.payload.isAddingItem
            }
        }
        default: {
            return ((x: never) => x)(action)
        }
    }
}