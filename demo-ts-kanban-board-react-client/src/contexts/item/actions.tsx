import { Dispatch } from 'react'
import { ACTION, ItemAction, ItemActions, } from './types'

export const getItemActions = (dispatch: Dispatch<ItemAction>): ItemActions => ({
    clearItem: () => {
        dispatch({
            type: ACTION.CLEAR_ITEM,
        })
    },
    setIsAddingItem: (isAddingItem: boolean) => {
        dispatch({
            type: ACTION.SET_IS_ADDING_ITEM,
            payload: { isAddingItem },
        })
    },
    setItemTitle: (title: string) => {
        dispatch({
            type: ACTION.SET_ITEM_TITLE,
            payload: { title },
        })
    },
    setItemDescription: (description: string) => {
        dispatch({
            type: ACTION.SET_ITEM_DESCRIPTION,
            payload: { description },
        })
    },
})