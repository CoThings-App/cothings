# CoThings

# Codename: Co-Living

![Elixir CI](https://github.com/cothings-app/cothings/workflows/Elixir%20CI/badge.svg)
[![GitHub last commit](https://img.shields.io/github/last-commit/cothings-app/cothings)](https://github.com/cothings-app/cothings/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/cothings-app/cothings)](https://github.com/cothings-app/cothings/issues)
[![License](https://img.shields.io/github/license/cothings-app/cothings)](LICENSE.md)

CoThings is application to account for current number of people using shared areas or utilities in realtime. The project’s main purpose is avoiding you to visit crowded areas during COVID-19 pandemic if you live in a community.

Without any restriction anyone can update the counter in case of people forget to update their status. 

It uses socket for realtime communication. 

You can see the project overall progress from [here](https://github.com/cothings-app/coliving/projects/4)

You can checkout applications' designs from [here](https://github.com/cothings-app/design)

For automatic room updates (on enter and exit) you need a beacon installed in the area and the iOS application.

Here's our [iOS Application](https://github.com/cothings-app/ios)

You can download the iOS application from the App Store

[![](https://developer.apple.com/app-store/marketing/guidelines/images/badge-example-preferred_2x.png)](https://apps.apple.com/app/CoThings/id1523609550)

Here's our [Demo Web Site](https://demo.cothings.app).

And here's a screenshot that we use for our share-house facility:

## Contributions

Any contributions are welcome. Here is some categories that you might help with:

- Designing
- Frontend development
- Backend development
- Mobile apps development

## Contact with the team

- info@cothings.app
- IRC channel on freenode.net #cothings

## Technical Information

Currently the project is being developed in [Elixir](https://elixir-lang.org/) + [Phoenix Framework](https://www.phoenixframework.org/). In the future we might separate the backend and frontend.

You can run the web application on your server with Docker using docker-compose. How to part will be detailed later.

# How to run the app for Production

Please always chekcout the latest release documentation for Phoenix from [here](https://hexdocs.pm/phoenix/deployment.html)

#### Stack Versions

**Elixir:** `1.12.3`

**Erlang/OTP:** `22`

**Phoenix:** `1.6.0`

# Run as a Docker Container

1. Create `.env` file in the root folder of the project or `mv .env.example .env` and set the environment variables as needed.
Here's some explanation of some environment values.

    `SECRET_KEY_BASE` is an unique key to sign in your cookie and session, to not save it plain. Keep it secret! Don't commit it. You should generate your own by using mix command `mix phx.gen.secret`

    `DATABASE_URL` is pretty clear. Should be something like this `ecto://db_user:db_password@db_hostname/coliving_prod`

    `POOL_SIZE` Your database's connection pool size

    `HOST` Your app's domain. You need it in order to confirm the handshaking between clients.

    `APP_TITLE` "CoThings" is the default app title however feel free to  change the app's title, but you need to keep the credits at the bottom acccording to the license.

    `ADMIN_USERNAME` and `ADMIN_PASSWORD` are the credentials for managing rooms. To access the rooms management the url is `/rooms`
    
    `LOG_ROOM_USAGE` let the application create room usage logs. Default: `false`

    `APP_IMAGE_URL` You can setup an header image for your application. If not, we're going to use this [photo](https://unsplash.com/photos/qCjolcMFaLI) by [Daniel DiNuzzo @ddinuzzo](https://unsplash.com/@ddinuzzo) on [Unsplash](https://unsplash.com/).

    `SERVER_SOURCE_CODE_URL` Due to AGPL-3.0 license requirements you have to provide the server's source code.
    In case you haven't modified the source code; you can use original repo's url from https://cothings.app/code

    `IOS_SOURCE_CODE_URL` Due to GPL-3.0 license requirements you have to provide the iOS application's source code.
    In case you haven't modified the source code; you can use original repo's url from https://cothings.app/code

1. Update your database settings and persistent volume paths in `docker-compose.yml` file. You can keep track of bussiest days of the week and time of the day for the room usage.

1. There are two ways to have the docker image:

    1. Build the image by yourself `docker build -t coliving .` Please note that, since out `Dockerfile` use multistage build, you will need Docker version 17.05 or later.

    1. Or you can use our [initial release](https://github.com/cothings-app/cothings/releases/) _docker image_ by pull it like this: `docker pull cothings/web-app:latest` or specify in the _image_ and the _tag_ in `docker-compose.yml` file.

1. Now run the application `docker-compose up -d`

1. See the logs `docker-compose logs` to confirm your `hostname` is written in the logs.

1. ⚠️ Once you've released and ran the app on production, you need to run migration. Run the following command.

`docker exec -it {container_name} bash bin/coliving eval Coliving.Release.migrate`

# Run with Kubernetes using Helm Charts

Kubernetes deployments are supported, by using Helm. Chart can be found under [deployment/kubernetes/chart](deployment/kubernetes/chart).

# Run in Local Environment (or for Development purpose)
To run the project in your local:

  * You'll need a PostgreSQL (docker) instance in your local
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
