# Co-living

![Elixir CI](https://github.com/rainlab-inc/coliving/workflows/Elixir%20CI/badge.svg)

Co-living service aims to help avoiding crowded areas for co-living spaces, like a share-house or a guest house's kitchens to prevent COVID-19 pandemic.

For now, it's only a web application and it needs to update the status of the current room manually. Without any restriction anyone can update the counter in case of people forget to update their status. It uses socket for realtime communication.

Here's a screenshot that we use for our share-house's kitchen:

![Lobby](https://github.com/rainlab-inc/coliving/blob/master/assets/static/images/app_screenshot_lobby.png "Lobby Overall")
![Room](https://github.com/rainlab-inc/coliving/blob/master/assets/static/images/app_screenshot_room.png "Room Stats")

Soon, there will be mobile clients to update the counters automatically using beacons.

## Roadmap as Todos
- Graphs for lobby
- Authorization plug for managing rooms
- Separate Backend and Frontend
- Statistics
    - Busiest time of the day
    - Busiest day of the week
    - etc.

## Currently working on
- [ ] Create mobile clients with beacon support
    - [ ] Android
    - [ ] iOS

## Done
- [x] Extend the idea for multiple rooms
    ✓ Washing machines
    ✓ Dryers
    ✓ Bathrooms
    ✓ For anything
- [x] Create a lobby for all rooms
    - [x] Update the lobby on single room update
    - [x] Track single room
- [x] Set maximum limit of the usage (for washing machines, dryers etc.)
- [x] Grouping the rooms
    - [x] Backend
    - [x] Frontend
    - [x] UI improvements


## Contributions
Any contributions are welcome. Here is some categories that you might help with:
 - Designing
 - Frontend development
 - Backend development
 - Mobile apps development

## Technical Information

Currently the project is been developed in Elixir + Phoenix Framework. In the future we might separate the backend and frontend.

You can run the web application on your server with Docker using docker-compose. How to part will be detailed later.

To run the project in your local:

  * You'll need a PostreSQL instance in your local
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
