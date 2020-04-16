# Co-living

![Elixir CI](https://github.com/rainlab-inc/coliving/workflows/Elixir%20CI/badge.svg)
[![GitHub last commit](https://img.shields.io/github/last-commit/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/issues)
[![License](https://img.shields.io/github/license/rainlab-inc/coliving)](LICENSE.md)
[![Tweet](https://img.shields.io/twitter/url?url=https%3A%2F%2Fgithub.com%2Frainlab-inc%2Fcoliving)](	https://img.shields.io/twitter/url?url=https%3A%2F%2Fgithub.com%2Frainlab-inc%2Fcoliving)

Co-living service aims to help avoiding crowded areas for co-living spaces, like a share-house or a guest house's kitchens to prevent COVID-19 pandemic.

For now, it's only a web application and it needs to update the status of the current room manually. Without any restriction anyone can update the counter in case of people forget to update their status. It uses socket for realtime communication.

Here's some screenshots that we use for our share-house's facility:

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

Currently the project is being developed in Elixir + Phoenix Framework. In the future we might separate the backend and frontend.

You can run the web application on your server with Docker using docker-compose. How to part will be detailed later.

## Release

Once you release and ran the app on production, you may need to run migration like this:

`/bin/coliving eval "Coliving.Release.migrate"`

## Local
To run the project in your local:

  * You'll need a PostgreSQL instance in your local
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
