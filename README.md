### Q&A

Pick one of the questions below.

- Describe why React is useful, and any thoughts on pros or cons you might have.
    - React utilizes a component-based architecture, which means that elements of the user interface are implemented as components that are re-usable, modular, and easier to maintain. In addition to this, React performs render updates using the virtual DOM, which improves performance.
    - React is frequently updated, which makes long-term maintenance difficult. I have worked professionally on many projects that required a large amount of code refactoring in order to update to the latest version of React or Node.js. The frequency of updates to React causes long-term maintenance to be complicated.
    - React does not effectively handle SEO without something like Next.js/SSR.

- If you wanted to improve the performance of a web app you were working on, what are
some things you would look at / try?
    - Caching can be utilized to optimize API calls (React-Query).
    - Static site generation (SSG) can be used to pre-render pages at build time, which will reduce server load and page load.
        - Similarly, server-side rendering (SSR) can be used to dynamically generate pages on the server for-each request, which reduces client-side Javascript execution and decreasing page load.
    - Indexing, caching, and connection polling are all examples of database query optimizations, that decrease response time from a server that accesses a database, which will improve performance in a web app.
    - The frequency of function execution during event-heavy operations (e.g. typing in a search string) can be controlled using debouncing and throttling, which helps improve performance by avoiding unnecessary calls.
    - Images should be served using a CDN to decrease load time because they will store the image in many physical locations, which decreases the distance between client and server.
    - In react, unnecessary re-renders or calculations can be avoided by using `useMemo` and `useCallback` hooks. This is essentially a caching mechanism for calculations and function creations.

- In your experience, what do you consider to be the difference between a mid-level and
senior-level engineer?
    - A mid-level engineer can work autonomously on new features, but may need some guidance from senior-level engineers. This type of role focuses on execution of tasks/features.
    - A senior-level engineer is thinking more in terms of system architecture, and how to design a system that will perform well at scale. Additionally, a senior-level engineer is responsible for mentoring and facilitating the best practices for a team.
    - A senior-level engineer needs to focus more on team orchestration, team problem solving (e.g. ensuring a mid-level dev is aware of an issue in their delivery and working with them to solve it), and planning the product roadmap.

### Backend Coding
1. Class Design
- Directories:
    - `demo-ruby-classes`
    - `demo-ruby-classes-rails-api`

2. Database And Model Designs With Queries
- Directories:
    - `demo-ruby-db-queries-rails-api`

### JS/React/CSS
1. Kanban Board UI
- Directories:
    - `demo-ts-kanban-board-react-client`
