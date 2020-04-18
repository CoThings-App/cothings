# Co-Living

![Elixir CI](https://github.com/rainlab-inc/coliving/workflows/Elixir%20CI/badge.svg)
[![GitHub last commit](https://img.shields.io/github/last-commit/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/issues)
[![License](https://img.shields.io/github/license/rainlab-inc/coliving)](LICENSE.md)

Co-living service aims to help avoiding crowded areas for co-living spaces, like a share-house or a guest house's kitchens to prevent COVID-19 pandemic.

For now, it's only a web application and it needs to update the status of the current room manually. Without any restriction anyone can update the counter in case of people forget to update their status. It uses socket for realtime communication.

You can see the project overall progress from [here](https://github.com/rainlab-inc/coliving/projects/4)

Here's some screenshots that we use for our share-house's facility:

![Lobby](https://github.com/rainlab-inc/coliving/blob/master/assets/static/images/app_screenshot_lobby.png "Lobby Overall")
![Room](https://github.com/rainlab-inc/coliving/blob/master/assets/static/images/app_screenshot_room.png "Room Stats")

Soon, there will be mobile clients to update the counters automatically using beacons.

Here's our [iOS Application](https://github.com/rainlab-inc/coliving-ios)

## Contributions
Any contributions are welcome. Here is some categories that you might help with:
 - Designing
 - Frontend development
 - Backend development
 - Mobile apps development

## Technical Information

Currently the project is being developed in [Elixir](https://elixir-lang.org/) + [Phoenix Framework](https://www.phoenixframework.org/). In the future we might separate the backend and frontend.

You can run the web application on your server with Docker using docker-compose. How to part will be detailed later.

## Release

Please always chekcout the latest release documentation for Phoenix from [here](https://hexdocs.pm/phoenix/deployment.html)

Here's some quick info for releasing the app by yourself until [this task](https://github.com/rainlab-inc/coliving/projects/4#card-36534840) being done

- Change the `host` of `url` in `config/prod.exs` for socket handshaking.
```elixir
config :coliving, ColivingWeb.Endpoint,
  url: [host: "example.com", port: 80],
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json"
  ```

Once you release and ran the app on production, you may need to run migration like this:

`/bin/coliving eval "Coliving.Release.migrate"`

## Local Development
To run the project in your local:

  * You'll need a PostgreSQL instance in your local
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
