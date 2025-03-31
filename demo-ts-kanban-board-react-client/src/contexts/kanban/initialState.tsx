import { KanbanState } from './types'

export const initialState: KanbanState = {
    items: {
        'Todo': ['Bootstrap React Project', 'Bootstrap Ruby On Rails Project', 'Containerize API', 'Containerize Client'],
        'Doing': [],
        'Done': [],
        'Archived': [],
    },
    cards: {
        'Bootstrap React Project': {
            title: "Bootstrap React Project",
            description: "Use Vite to bootstrap a new React project, then create a healthcheck route page"
        },
        'Bootstrap Ruby On Rails Project': {
            title: "Bootstrap Ruby On Rails Project",
            description: "Use Rails to bootstrap a new Ruby on Rails API project, then create a healthcheck API endpoint"
        },
        'Containerize API': {
            title: "Containerize API",
            description: "Use Docker to containerize the bootstrapped Ruby on Rails API project."
        },
        'Containerize Client': {
            title: "Containerize Client",
            description: "Use Docker to containerize the bootstrapped Vite React client project."
        },
    }
}