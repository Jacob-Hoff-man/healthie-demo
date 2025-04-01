# Demo - TypeScript Kanban Board React Client

### Problem Description

If you are a React coder, use React (preferably Typescript). Otherwise, code in the JS framework of your
choice.

Make a frontend-only todo list app.
- It has three vertical lists. Todo, Doing, and Done
- Items are created via a form (they can be stored in browser state, no need to have a backend)
- Items are draggable from one list to another
- Items can be reordered within a list
- When you drag an item into the Done list, confetti explodes on the screen! Or something else interesting. You can use a package for this.
- Overall the app has a usable design with a unique color palette. You are free to make whatever UI and UX decisions you want to make it usable. Don't worry, we aren't looking for a groundbreaking innovative design. Just lay things out decently and add some colors.
- Using Typescript will get you bonus points.

### Problem Solution

- `antd` component library is used for React components.
- `dnd-kit` is used for handling draggable and sortable component references.
- `react-rewards` is used for rendering confetti.
- There are contexts for handling state manamement, which use an action reducer pattern:
    - `kanban` context manages items maps for each column.
    - `item` context manages the configuration of a new item object to add in a column.
- The project currently supports the following actions:
    - Create a new card within a column.
    - Delete a specific card.
    - Drag and drop the columns to sort in any order.
    - Drag and drop the cards to sort in any order and to move into any column.
    - Drag and drop a card into the 'Done' column to trigger confetti.

### How To Run

- In a terminal, traverse to the `demo-ts-kanban-board-react-client` directory
    - Run `npm install` to install dependencies
    - Run `npm run dev` to locally deploy the client project.
    - Visit `localhost:8173` in a web browser to access the client project.

### Other

- The Vite project was generated using the following command:
```
npm create vite@latest demo-ts-kanban-board-react-client --template react
```
- The approach for developing the kanban board using `dnd-kit` was based on the following guide:
```
https://next.dndkit.com/react/guides/multiple-sortable-lists
```