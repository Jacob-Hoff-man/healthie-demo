import { ReactNode, useMemo, useReducer } from 'react'
import { initialState } from './initialState'
import { itemStateReducer } from './reducer'
import { getItemActions } from './actions'
import { ItemActionsContext, ItemContext } from './context'

type ItemProviderProps = {
    children: ReactNode
}

const ItemProvider = ({ children }: ItemProviderProps) => {
    const [itemState, dispatch] = useReducer(itemStateReducer, {
        ...initialState,
    })
    const ItemActions = useMemo(() => getItemActions(dispatch), [])

    return (
        <ItemContext.Provider value={itemState}>
            <ItemActionsContext.Provider value={ItemActions}>{children}</ItemActionsContext.Provider>
        </ItemContext.Provider>
    )
}

export default ItemProvider