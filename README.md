# Node Development Environment

> Streamline setting up your next project's workspace!

Are you tired of wasting so much time fighting with your local machine long before you can even start on your next passion project? Do you get frustrated with debugging issues rooted in your machine's filesystem, OS, or some other unknown X-factor that you have no idea what could be causing it?

So was I, which was why I decided to create my own DevContainer to help better streamline the process for my future programable endeavors.

Through the power of VSCode and Docker, you can setup your own workspace with ease of process as well as ease of mind.

## System Requirements

While this system is still provides its own isolated & independent environment, there are still a couple of things you'll need on your system before you get started.

1. [Visual Studio Code](https://code.visualstudio.com/download)
2. [Docker](https://docs.docker.com/get-docker/)
3. [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   * This one requires for you to have Visual Studio Code (VSCode) installed first, as this is an extension for the popular code editor.

If you do not know how to install Visual Studio Code or Docker, then please refer to the respective site's documentation for more information.

### Important Note

As of the date of this commit -- May 15, 2021 -- I've developed this using Docker's integrated WSL (Ubuntu 20.04 | x86_64) on my machine that primarily runs Windows 10 Pro, so the information I give is based solely on that environment.

## Usage

1. Clone or download this repo into its own private directory.
2. Copy the `.devcontainer` directory over to your project.
3. Configure the details how you want (more details on those customizable features later on) in the following file: `.devcontainer/scripts/build_config.sh` and `.devcontainer/.env`.
4. Make sure your Docker daemon is running and then open your project in Visual Studio code.
5. Press `Ctrl + Shift + P` to open up text field.
6. Search for `Remote-Containers: Rebuild and Reopen Containers`.
7. Once you have that option selected, either click on it or press `Enter`.
8. Docker-Compose will then build your container(s). Once that's completed, your instance of VSCode will reload and will open up inside your new DevContainer. Enjoy!

## Features

### GitHub

While this is in  an isolated environment, this will automatically copy over your GitHub credentials, assuming you have them set up with the following commands:

```bash
git config --global user.name "Mona Lisa"
git config --global user.email "monalisa@neversmiles.com"
```

### GitHub SSH Keys

If you use GitHub SSH key, the DevContainer is setup for that through the use of the `$SSH_AUTH_SOCK` variable where it'll share your credentials safely and without compromising your security.

That method is a bit trickier, however, is you'll need an SSH-Agent to forward your keys through the container's SSH socket.

**Note:** These instructions are based on WSL Ubuntu.

Run the following commands to install `keychain` as a dependency:

```bash
sudo apt-get update && sudo apt-get install keychain 
```

Copy & Paste the following script into `~/.profile` or `~/.bash_profile` (`~/.zprofile` for ZSH):

```bash
eval $(keychain --quiet --eval --agents ssh id_ed25519)

if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent`
fi
```

This script will ensure your SSH key(s) are made available from within the container.

### Docker-in-Docker

> Yo, dawg! I heard you like Docker containers, so I put a Docker containers *inside* your Docker container!

That's right! You can actually start your own game of *Inception* by building nested Docker containers with either Docker CLI or Moby CLI and Docker-Compose.

#### Options

| Env Variable Name     | Default Value | Purpose                                           |
|-----------------------|---------------|---------------------------------------------------|
| $USE_MOBY             | false         | This will install Moby CLI instead of Docker CLI. |
| ENABLE_NONROOT_DOCKER | true          | Assign Docker permissions either to root or node. |

You can even access this container *from* other Docker containers or vice versa.

**Important Note:** This has not been fully tested yet, so I do not know the limitations of this within the current setup.

### NPM / Yarn

This installs the latest version of NPM & Yarn package managers.

**NVM Note:** NVM is removed by default from this container to help eliminate any unneeded complications, but you can allow it in the container's build by setting the `$KEEP_NVM` variable in `.env` to `TRUE`.

#### List of Global Dependencies Installed

* node-gyp
* node-sass
* http-server
* ndb
* npm-check
* npm-check-updates
* pm2
* rimraf
* snyk
* typescript
* @commitlint/cli

There are also other configurable options for what global command line tools are installed, depending on your Node Project's needs:

| Dependency     | ENV Variable Name | Default |
|----------------|-------------------|---------|
| @angular/cli   | $USE_ANGULAR      | false   |
| @nestjs/cli    | $USE_NESTJS       | false   |
| @nrwl/cli      | $USE_NRWL         | false   |
| @capacitor/cli | $USE_IONIC        | false   |
| @ionic/cli     | $USE_IONIC        | false   |
| cordova        | $USE_IONIC        | false   |

### MongoDB

By default, this DevContainer comes setup with MongoDB straight out of the box. Although, if you wish to remove it, simply comment out the sections involving MongoDB from the `docker-compose.yml` file and set `USE_MONGO` to false.

#### MongoDB Configuration Options

| ENV Variable Name          | Default                |
|----------------------------|------------------------|
| USE_MONGO                  | true                   |
| MONGO_VARIANT*             | 4.4.6                  |
| MONGO_HOST                 | dev-container-database |
| MONGO_PORT                 | 6379                   |
| MONGO_INITDB_ROOT_USERNAME | root                   |
| MONGO_INITDB_ROOT_PASSWORD | example                |
| MONGO_INITDB_DATABASE      | your-database-here     |

*`MONGO_VARIANT` is to depict the version of the MongoDB command line tools you wish to use.

### Redis Server

By default, this DevContainer comes setup with Redis straight out of the box. Although, if you wish to remove it, simply comment out the sections involving Redis from the `docker-compose.yml` file and set `USE_REDIS` to false.

#### Redis Configuration Options

| ENV Variable Name | Default             |
|-------------------|---------------------|
| USE_REDIS         | true                |
| REDIS_VARIANT*    | 6.2.3               |
| REDIS_HOST        | dev-container-cache |
| REDIS_PORT        | 27017               |

*`REDIS_VARIANT` is to depict the version of the Redis Server command line tools you wish to use.

**Important Note:** This instance of Redis is configured with AOF turned off, uses RDB, and is using standard LRU eviction policies. If you wish to change any of these settings, go to `.devcontainer/redis/redis.conf` to adjust accordingly. But please be sure to reference Redis' documentation while you do.

### List of Bash Aliases

```bash
alias cra="npx create-react-app"
alias create-react-app="npx create-react-app"
alias create-nx-workspace="npx create-nx-workspace"
alias l="ls -CF"
alias la="ls -A"
alias lerna="npx lerna"
alias ll="ls -la"
alias redis="redis-cli"
```

## Personal Disclaimer

This is my first time attempting to create an open-source project, so I apologize if this isn't the most flexible or customizable OSS project hosted on GitHub right now. This is but the first version -- a prototype if you will -- and I plan to refine it over time. Although, I also welcome others to contribute, and for those more familiar with OSS practices to offer up any advice they can provide. I'm very open to feedback and constructive criticisms.

## Meta

Kerick Howlett - [LinkedIn](https://linkedin.com/in/KerickHowlett) - kahowlett1989@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/KerickHowlett](https://github.com/KerickHowlett)

## Contributing

1. Fork it
2. Create your feature branch off the development branch. (`git checkout -b feature/fooBar development`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
