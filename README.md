# CoThings
# Codename: Co-Living

![Elixir CI](https://github.com/rainlab-inc/coliving/workflows/Elixir%20CI/badge.svg)
[![GitHub last commit](https://img.shields.io/github/last-commit/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/issues)
[![License](https://img.shields.io/github/license/rainlab-inc/coliving)](LICENSE.md)

CoThings is application to account for current number of people using shared areas or utilities in realtime. The project’s main purpose is avoiding you to visit crowded areas during COVID-19 pandemic if you live in a community.

For now, it's only a web application and it needs to update the status of the current room manually. Without any restriction anyone can update the counter in case of people forget to update their status. It uses socket for realtime communication.

You can see the project overall progress from [here](https://github.com/rainlab-inc/coliving/projects/4)

You can checkout applications' designs from [here](https://github.com/rainlab-inc/cothings-design)

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

# How to run the app for Production

Please always chekcout the latest release documentation for Phoenix from [here](https://hexdocs.pm/phoenix/deployment.html)

#### Stack Versions
**Elixir:** `1.10.0`

**Erlang/OTP:** `22`

**Phoenix:** `1.4.16`

## Run as a Docker Container

1. Create `.env` file in the root folder of the project or `mv .env.example .env` and set the environment variables as needed.
Here's some explanation of some environment values.

    `SECRET_KEY_BASE` is an unique key to sign in your cookie and session, to not save it plain. Keep it secret! Don't commit it. You should generate your own by using mix command `mix phx.gen.secret`

    `DATABASE_URL` is pretty clear. Should be something like this `ecto://db_user:db_password@db_hostname/coliving_prod`

    `POOL_SIZE` Your database's connection pool size

    `HOST` Your app's domain. You need it in order to confirm the handshaking between clients.

    `APP_TITLE` "CoThings" is the default app title however feel free to  change the app's title, but you need to keep the credits at the bottom acccording to the license.

    `ADMIN_USERNAME` and `ADMIN_PASSWORD` are the credentials for managing rooms. To access the rooms management the url is `/rooms`

1. Update your database settings and persistent volume paths in `docker-compose.yml` file.

1. There are two ways to have the docker image:

   1. Build the image by yourself `docker build -t coliving .` Please note that, since out `Dockerfile` use multistage build, you will need Docker version 17.05 or later.

   1. Or you can use our [initial release](https://github.com/rainlab-inc/cothings/releases/tag/v0.1.0) _docker image_ by pull it like this: `docker pull dkr.rlab.io/cothings/web-app:v0.1.0` or specify in the _image_ and the _tag_ in `docker-compose.yml` file.

1. Now run the application `docker-compose up -d`

1. See the logs `docker-compose logs` to confirm your `hostname` is written in the logs.

1. ⚠️ Once you've released and ran the app on production, you need to run migration. Run the following command.

`docker exec -it {container_name} bash bin/coliving eval Coliving.Release.migrate`

# Run in Local Environment (or for Development purpose)
To run the project in your local:

  * You'll need a PostgreSQL (docker) instance in your local
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
