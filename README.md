# CoThings
# Codename: Co-Living

![Elixir CI](https://github.com/rainlab-inc/coliving/workflows/Elixir%20CI/badge.svg)
[![GitHub last commit](https://img.shields.io/github/last-commit/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/rainlab-inc/coliving)](https://github.com/rainlab-inc/coliving/issues)
[![License](https://img.shields.io/github/license/rainlab-inc/coliving)](LICENSE.md)

CoThings helps you avoiding crowded areas for co-living spaces, like a share-house or a guest house's kitchens to prevent COVID-19 pandemic.

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

## Release the app for production

Please always chekcout the latest release documentation for Phoenix from [here](https://hexdocs.pm/phoenix/deployment.html)

#### Stack Versions
**Elixir:** `1.10.0`
**Erlang/OTP:** `22`
**Phoenix:** `1.4.16`

# Release the app with a docker container
- Create `.env` file in the root folder of the project and set the environment variables as needed.
Here's an example:

```bash
SECRET_KEY_BASE= # use mix phx.gen.secret to create one, without quote
DATABASE_URL=ecto://db_user:db_password@db_hostname/coliving_prod
POOL_SIZE=20 #your db's connection pool size
HOST=cothings.yourdomain.com
APP_TITLE="CoThings" # feel free to  change the app's title, but you need to keep the 
PORT=4004
LANG=en_US.UTF-8
REPLACE_OS_VARS=true
MIX_ENV=prod
ADMIN_USERNAME=#without quote 
ADMIN_PASSWORD=#without quote
```
- Update your database settings in `docker-compose.yml` file.
- Build the image `docker build -t cothings .` Please note that, since out `Dockerfile` use multistage build, you will need Docker version 17.05 or later.
- Now run the application `docker-compose up -d`
- To see the logs `docker-compose logs`

Once you've released and ran the app on production, you need to run migration. First connect to the container. 

`docker exec -it {container_name} bash bin/coliving eval Coliving.Release.migrate`

## Local Development
To run the project in your local:

  * You'll need a PostgreSQL instance in your local (We recommend use a docker container in your local, however it's totally up to you
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
