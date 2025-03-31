import { ACTION, KanbanAction, KanbanState } from "./types"

export const kanbanStateReducer = (state: KanbanState, action: KanbanAction): KanbanState => {
    switch (action.type) {
        case ACTION.SET_ITEMS: {
            return {
                ...state,
                items: action.payload.items
            }
        }
        case ACTION.ADD_ITEM: {
            return {
                ...state,
                items: { ...state.items, [action.payload.columnId]: [...state.items[action.payload.columnId], action.payload.item.title] },
                cards: { ...state.cards, [action.payload.item.title]: action.payload.item }
            }
        }
        case ACTION.REMOVE_ITEM: {
            return {
                ...state,
                items: { ...state.items, [action.payload.columnId]: state.items[action.payload.columnId].filter(item => item !== action.payload.item) }
            }
        }
        default: {
            return ((x: never) => x)(action)
        }
    }
}