import { ACTION, KanbanAction, KanbanState } from "./types"

export const kanbanStateReducer = (state: KanbanState, action: KanbanAction): KanbanState => {
    switch (action.type) {
        case ACTION.SET_ITEMS: {
            return {
                ...state,
                items: action.payload.items
            }
        }
        default: {
            return ((x: never) => x)(action)
        }
    }
}