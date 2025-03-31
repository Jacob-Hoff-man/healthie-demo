import { Dispatch } from 'react'
import { ACTION, KanbanAction, KanbanActions } from './types'
import { Items } from '../../types/kanban'

export const getKanbanActions = (dispatch: Dispatch<KanbanAction>): KanbanActions => ({
    setItems: (items: Items) => {
        dispatch({
            type: ACTION.SET_ITEMS,
            payload: {
                items
            },
        })
    },
    addItem: (columnId: string, item: string) => {
        dispatch({
            type: ACTION.ADD_ITEM,
            payload: { columnId, item },
        })
    },
    removeItem: (columnId: string, item: string) => {
        dispatch({
            type: ACTION.REMOVE_ITEM,
            payload: { columnId, item },
        })
    },
})