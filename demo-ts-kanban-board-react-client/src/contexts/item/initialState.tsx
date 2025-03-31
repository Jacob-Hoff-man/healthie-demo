import { ItemState } from './types'

export const initialState: ItemState = {
    item: {
        title: '',
        description: '',
    },
    isAddingItem: false,
}