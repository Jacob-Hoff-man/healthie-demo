import { createContext, useContext } from 'react'
import { ItemActions, ItemState } from './types'

export const ItemContext = createContext<ItemState>({} as ItemState)
export const ItemActionsContext = createContext<ItemActions>({} as ItemActions)

export const useItemContext = () => useContext(ItemContext)
export const useItemActionsContext = () => useContext(ItemActionsContext)