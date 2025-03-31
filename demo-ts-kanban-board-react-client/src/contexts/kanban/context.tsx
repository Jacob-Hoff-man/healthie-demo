import { createContext, useContext } from 'react'
import { KanbanActions, KanbanState } from './types'

export const KanbanContext = createContext<KanbanState>({} as KanbanState)
export const KanbanActionsContext = createContext<KanbanActions>({} as KanbanActions)

export const useKanbanContext = () => useContext(KanbanContext)
export const useKanbanActionsContext = () => useContext(KanbanActionsContext)