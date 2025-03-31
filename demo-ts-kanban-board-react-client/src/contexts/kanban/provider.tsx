import { ReactNode, useMemo, useReducer } from 'react'
import { kanbanStateReducer } from './reducer'
import { initialState } from './initialState'
import { KanbanActionsContext, KanbanContext } from './context'
import { getKanbanActions } from './actions'

type KanbanProviderProps = {
    children: ReactNode
}

const KanbanProvider = ({ children }: KanbanProviderProps) => {
    const [kanbanState, dispatch] = useReducer(kanbanStateReducer, {
        ...initialState,
    })
    const KanbanActions = useMemo(() => getKanbanActions(dispatch), [])

    return (
        <KanbanContext.Provider value={kanbanState}>
            <KanbanActionsContext.Provider value={KanbanActions}>{children}</KanbanActionsContext.Provider>
        </KanbanContext.Provider>
    )
}

export default KanbanProvider