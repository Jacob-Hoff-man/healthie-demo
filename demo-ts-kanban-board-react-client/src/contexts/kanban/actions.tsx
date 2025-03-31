import { Dispatch } from 'react'
import { ACTION, KanbanAction, KanbanActions } from './types'
import { Items } from '../../types/item'

export const getKanbanActions = (dispatch: Dispatch<KanbanAction>): KanbanActions => ({
    setItems: (items: Items) => {
        dispatch({
            type: ACTION.SET_ITEMS,
            payload: {
                items
            },
        })
    },
})