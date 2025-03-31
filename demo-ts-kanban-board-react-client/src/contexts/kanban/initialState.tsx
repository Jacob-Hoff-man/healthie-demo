import { KanbanState } from './types'

export const initialState: KanbanState = {
    items: {
        'col-1': ['id-1', 'id-2', 'id-3'],
        'col-2': ['id-4', 'id-5', 'id-6'],
        'col-3': ['id-7', 'id-8', 'id-9'],
    },
}